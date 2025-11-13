//
//  ContentView.swift
//  13
//
//  Created by user on 11/7/25.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    private var showFullName = true
    
    private let firstName = "Иван"
    private let lastName = "Иванов"
    private let middleName = "Иванович"
    private let position = "Разработчик iOS"
    private let address = "г. Москва, ул. Пушкина, д. 1, кв. 1"
    
    private var fullName: String {
        "\(lastName) \(firstName) \(middleName)"
    }
    
    private var shortName: String {
        firstName
    }
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let positionLabel = UILabel()
    private let addressLabel = UILabel()
    private let toggleButton = UIButton(type: .system)
    private let copyButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        nameLabel.text = fullName
        nameLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        positionLabel.text = position
        positionLabel.font = .systemFont(ofSize: 16)
        positionLabel.textColor = .secondaryLabel
        positionLabel.textAlignment = .center
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(positionLabel)
        
        let addressText = "Адрес: \(address)"
        let attributedString = NSMutableAttributedString(string: addressText)
        let range = (addressText as NSString).range(of: "Адрес:")
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .medium), range: range)
        addressLabel.attributedText = attributedString
        addressLabel.font = .systemFont(ofSize: 16)
        addressLabel.textColor = .secondaryLabel
        addressLabel.textAlignment = .center
        addressLabel.numberOfLines = 0
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressLabel)
        
        toggleButton.setTitle("Показать имя", for: .normal)
        toggleButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        toggleButton.setTitleColor(.white, for: .normal)
        toggleButton.backgroundColor = .systemBlue
        toggleButton.layer.cornerRadius = 10
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toggleButton)
        
        copyButton.setTitle("Копировать адрес", for: .normal)
        copyButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.backgroundColor = .systemGreen
        copyButton.layer.cornerRadius = 10
        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(copyButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            positionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            positionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addressLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            toggleButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 30),
            toggleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toggleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toggleButton.heightAnchor.constraint(equalToConstant: 50),
            
            copyButton.topAnchor.constraint(equalTo: toggleButton.bottomAnchor, constant: 15),
            copyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            copyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            copyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func toggleButtonTapped() {
        showFullName.toggle()
        nameLabel.text = showFullName ? fullName : shortName
        toggleButton.setTitle(showFullName ? "Показать только имя" : "Показать полное ФИО", for: .normal)
    }
    
    @objc private func copyButtonTapped() {
        UIPasteboard.general.string = address
    }
}
