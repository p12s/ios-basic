//
//  MainView.swift
//  19
//
//  Created by user on 11/29/25.
//
import UIKit

protocol MainViewDelegate: AnyObject {
  func save(login: String, pass: String)
  func load()
}

final class MainView: UIView {
  weak var delegate: MainViewDelegate?
  
  private lazy var loginTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Логин"
    textField.borderStyle = .roundedRect
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  private lazy var passwordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Пароль"
    textField.borderStyle = .roundedRect
    textField.isSecureTextEntry = true
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  
  private lazy var saveButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Сохранить", for: .normal)
    button.backgroundColor = .systemBlue
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 8
    button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var loadButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Показать", for: .normal)
    button.backgroundColor = .systemGreen
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 8
    button.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    backgroundColor = .systemBackground
    addSubview(loginTextField)
    addSubview(passwordTextField)
    addSubview(saveButton)
    addSubview(loadButton)
    NSLayoutConstraint.activate([
      loginTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
      loginTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
      loginTextField.widthAnchor.constraint(equalToConstant: 250),
      loginTextField.heightAnchor.constraint(equalToConstant: 44),
      
      passwordTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
      passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
      passwordTextField.widthAnchor.constraint(equalToConstant: 250),
      passwordTextField.heightAnchor.constraint(equalToConstant: 44),
      
      saveButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -70),
      saveButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
      saveButton.widthAnchor.constraint(equalToConstant: 120),
      saveButton.heightAnchor.constraint(equalToConstant: 44),
      
      loadButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 70),
      loadButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
      loadButton.widthAnchor.constraint(equalToConstant: 120),
      loadButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  @objc private func saveButtonTapped() {
    let login = loginTextField.text ?? ""
    let pass = passwordTextField.text ?? ""
    delegate?.save(login: login, pass: pass)
  }
  
  @objc private func loadButtonTapped() {
    delegate?.load()
  }
  
  func setupData(_ creds: Creds) {
    loginTextField.text = creds.login
    passwordTextField.text = creds.pass
  }
}
