//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by user on 11/16/25.
//

import UIKit

class ViewController: UIViewController {

  private enum Constants {
    static let spacing: CGFloat = 10
    static let numberOfItemsPerRow: CGFloat =
    UIDevice.current.orientation == .portrait ? 3 : 6
  }
  
  private lazy var layout: UICollectionViewLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    // collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "customCell")
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    collectionView.collectionViewLayout.invalidateLayout()
    layout.invalidateLayout()
  }
  
  private func setup() {
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
  ])
  }
}

extension ViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    20
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "cell",
      for: indexPath
    )
    cell.backgroundColor = .systemBlue
    return cell
  }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let interimSpacing = (collectionView.collectionViewLayout as?
                          UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
    let width = collectionView.bounds.width - (Constants.numberOfItemsPerRow - 1) * interimSpacing
    let itemWidth = floor(width / Constants.numberOfItemsPerRow)
    return CGSize(width: itemWidth, height: itemWidth)
  }
}
