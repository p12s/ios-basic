import UIKit

final class CardsViewController: UIViewController {
    private let storageService: IStorageService = FileManagerService()
    private var cards: [Card] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        return collectionView
    }()
    
    private lazy var compositionalLayout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(250)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(250)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
        setupCollectionView()
    }
    
    private func setupDependencies() {
        cards = Card.makeMock()
        let storedCards = storageService.read(for: "favorites")
        if !storedCards.isEmpty {
            for card in cards {
                if storedCards.contains(where: { $0.id == card.id }) {
                    card.isFavorite = true
                }
            }
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.collectionViewLayout = compositionalLayout
        collectionView.contentInset = UIEdgeInsets(
            top: 16,
            left: 0,
            bottom: 0,
            right: 0
        )
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        let card = cards[indexPath.item]
        
        cell.configure(with: card)
        cell.onFavoriteTapped = { [weak self] in
            guard let self = self else { return }
            self.toggleFavorite(at: indexPath)
        }
        
        return cell
    }
    
    private func toggleFavorite(at indexPath: IndexPath) {
        guard indexPath.item < cards.count else { return }
        let card = cards[indexPath.item]
        card.isFavorite.toggle()
        
        if card.isFavorite {
            _ = storageService.create(from: card, at: "favorites")
        } else {
            _ = storageService.delete(model: card, at: "favorites")
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
            cell.updateFavoriteState(isFavorite: card.isFavorite)
        }
    }
}

extension CardsViewController: UICollectionViewDelegate {
    
}

