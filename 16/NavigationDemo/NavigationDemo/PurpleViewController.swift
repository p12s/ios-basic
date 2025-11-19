//
//  PurpleViewController.swift
//  NavigationDemo
//
//  Created by user on 11/19/25.
//

import UIKit

class PurpleViewController: UIViewController {
  
  var displayText: String?
  
  private lazy var closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Close", for: .normal)
    button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let textLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemPurple
    tabBarItem.title = "Fourth"
    navigationItem.title = "Fourth title"
    navigationController?.navigationBar.prefersLargeTitles = true
    view.addSubview(textLabel)
    view.addSubview(closeButton)
    NSLayoutConstraint.activate([
      textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      closeButton.widthAnchor.constraint(equalToConstant: 100),
      closeButton.heightAnchor.constraint(equalToConstant: 44)
    ])
    textLabel.text = displayText?.isEmpty == false ? displayText : "Нет текста"
  }
  
  @objc private func handleClose() {
    dismiss(animated: true)
  }
}
