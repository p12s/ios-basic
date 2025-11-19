//
//  ThirdViewController.swift
//  NavigationDemo
//
//  Created by user on 11/19/25.
//

import UIKit

class ThirdViewController: UIViewController {
  
  private let textField: UITextField = {
    let field = UITextField()
    field.placeholder = "Введите текст"
    field.borderStyle = .roundedRect
    field.translatesAutoresizingMaskIntoConstraints = false
    return field
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGray2
    tabBarItem.title = "Third 3d"
    navigationItem.title = "Third title"
    navigationController?.navigationBar.prefersLargeTitles = true
    textField.delegate = self
    view.addSubview(textField)
    NSLayoutConstraint.activate([
      textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
      textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      textField.heightAnchor.constraint(equalToConstant: 44)
    ])
    let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
    navigationItem.rightBarButtonItems = [
      makeBarButton(title: "Present", tag: 0),
      makeBarButton(title: "Push", tag: 1)
    ]
  }
  
  private func makeBarButton(title: String, tag: Int) -> UIBarButtonItem {
    let button = UIBarButtonItem(
      title: title,
      style: .plain,
      target: self,
      action: #selector(didTapSmthButton(_:))
    )
    button.tag = tag
    return button
  }
  
  @objc private func didTapSmthButton(_ sender: UIBarButtonItem) {
    let text = textField.text ?? ""
    switch sender.tag {
    case 0:
      let vc = PurpleViewController()
      vc.modalTransitionStyle = .coverVertical
      vc.displayText = text
      present(vc, animated: true)
    case 1:
      let vc = BlueViewController()
      vc.displayText = text
      navigationController?.pushViewController(vc, animated: true)
    default:
      break
    }
  }
}

extension ThirdViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
