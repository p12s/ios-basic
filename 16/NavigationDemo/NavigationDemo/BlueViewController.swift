//
//  BlueViewController.swift
//  NavigationDemo
//
//  Created by user on 11/19/25.
//

import UIKit

class BlueViewController: UIViewController {
  
  var displayText: String?
  
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
    view.backgroundColor = .systemBlue
    view.addSubview(textLabel)
    NSLayoutConstraint.activate([
      textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    textLabel.text = displayText?.isEmpty == false ? displayText : "Нет текста"
  }
}
