import UIKit

class SecondViewController: UIViewController {

  private enum Constants {
    static let spacing: CGFloat = 16
    static let itemsPerRowPortrait: CGFloat = 2
    static let itemWidth: CGFloat = 180
    static let itemHeight: CGFloat = 180
  }
  
  private var users: [User] = []
  
  private lazy var layout: UICollectionViewLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = Constants.spacing
    layout.minimumInteritemSpacing = Constants.spacing
    layout.sectionInset = UIEdgeInsets(
      top: Constants.spacing,
      left: Constants.spacing,
      bottom: Constants.spacing,
      right: Constants.spacing
    )
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(
      UserCollectionViewCell.self,
      forCellWithReuseIdentifier: UserCollectionViewCell.identifier
    )
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationItem.title = "Users"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    users = UserRepository.shared.getUsers()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    refreshUsers()
  }
  
  private func refreshUsers() {
    users = UserRepository.shared.getUsers()
    collectionView.reloadData()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: { _ in
      self.collectionView.collectionViewLayout.invalidateLayout()
    })
  }
  
  private func setup() {
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

extension SecondViewController: UserDetailViewControllerDelegate {
  func userDetailViewController(_ controller: UserDetailViewController, didUpdateUser user: User) {
    refreshUsers()
  }
}

extension SecondViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    users.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: UserCollectionViewCell.identifier,
      for: indexPath
    ) as! UserCollectionViewCell
    cell.configure(with: users[indexPath.item])
    return cell
  }
}

extension SecondViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let isPortrait = view.bounds.width < view.bounds.height
    if isPortrait {
      let availableWidth = collectionView.bounds.width - Constants.spacing * 3
      let itemWidth = floor(availableWidth / Constants.itemsPerRowPortrait)
      return CGSize(width: itemWidth, height: Constants.itemHeight)
    } else {
      return CGSize(width: Constants.itemWidth, height: Constants.itemHeight)
    }
  }
  
  func   collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedUser = users[indexPath.item]
    let vc = UserDetailViewController()
    vc.user = selectedUser
    vc.delegate = self
    navigationController?.pushViewController(vc, animated: true)
  }
}
