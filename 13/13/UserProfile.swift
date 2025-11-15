//
//  UserProfileViewController.swift
//  13
//
//  Created by user on 11/7/25.
//

import UIKit

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let lastName = "Иванов"
    private let firstName = "Иван"
    private let middleName = "Иванович"
    private let position = "iOS-разработчик"
    private let address = "г. Москва, ул. Ленина, д. 1"
    
    private var isShowingFullName = true

    private let avatarContainerView = UIView()
    private let imageView = UIImageView()
    private let cameraIconView = UIImageView()
    private let nameLabel = UILabel()
    private let positionLabel = UILabel()
    private let addressLabel = UILabel()
    private let editButton = UIButton(type: .system)
    private let toggleNameButton = UIButton(type: .system)
    private let copyAddressButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        avatarContainerView.layer.cornerRadius = 30
        avatarContainerView.clipsToBounds = true
        cameraIconView.layer.cornerRadius = 30
    }

    private func setupUI() {
        avatarContainerView.backgroundColor = .systemGray5
        avatarContainerView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainerView.clipsToBounds = true
        view.addSubview(avatarContainerView)

        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainerView.addSubview(imageView)

        cameraIconView.image = UIImage(systemName: "camera.fill")
        cameraIconView.tintColor = .white
        cameraIconView.backgroundColor = .systemBlue
        cameraIconView.contentMode = .center
        cameraIconView.clipsToBounds = true
        cameraIconView.isUserInteractionEnabled = true
        cameraIconView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainerView.addSubview(cameraIconView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cameraIconTapped))
        cameraIconView.addGestureRecognizer(tapGesture)

        nameLabel.text = getDisplayName()
        nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        toggleNameButton.setTitle("Показать только имя", for: .normal)
        toggleNameButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        toggleNameButton.setTitleColor(.white, for: .normal)
        toggleNameButton.backgroundColor = .systemBlue
        toggleNameButton.layer.cornerRadius = 12
        toggleNameButton.layer.borderWidth = 1
        toggleNameButton.layer.borderColor = UIColor.systemBlue.cgColor
        toggleNameButton.addTarget(self, action: #selector(toggleNameButtonTapped), for: .touchUpInside)
        toggleNameButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toggleNameButton)

        let personIcon = UIImage(systemName: "person")
        let attachment = NSTextAttachment()
        if let icon = personIcon {
            let iconImage = icon.withTintColor(.secondaryLabel)
            attachment.image = iconImage
        }
        let imageString = NSAttributedString(attachment: attachment)
        let positionText = NSMutableAttributedString()
        positionText.append(imageString)
        positionText.append(NSAttributedString(string: " \(position)"))
        positionLabel.attributedText = positionText
        positionLabel.font = .systemFont(ofSize: 16)
        positionLabel.textColor = .secondaryLabel
        positionLabel.textAlignment = .left
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(positionLabel)

        addressLabel.text = address
        addressLabel.font = .systemFont(ofSize: 16)
        addressLabel.textColor = .secondaryLabel
        addressLabel.textAlignment = .left
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addressLabel)

        editButton.setTitle("Редактировать", for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        editButton.setTitleColor(.white, for: .normal)
        editButton.backgroundColor = .systemBlue
        editButton.layer.cornerRadius = 12
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor.systemBlue.cgColor
        editButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(editButton)
        
        copyAddressButton.setTitle("Копировать адрес", for: .normal)
        copyAddressButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        copyAddressButton.setTitleColor(.white, for: .normal)
        copyAddressButton.backgroundColor = .systemBlue
        copyAddressButton.layer.cornerRadius = 12
        copyAddressButton.layer.borderWidth = 1
        copyAddressButton.layer.borderColor = UIColor.systemBlue.cgColor
        copyAddressButton.addTarget(self, action: #selector(copyAddressButtonTapped), for: .touchUpInside)
        copyAddressButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(copyAddressButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            avatarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            avatarContainerView.heightAnchor.constraint(equalTo: avatarContainerView.widthAnchor),

            imageView.topAnchor.constraint(equalTo: avatarContainerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: avatarContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: avatarContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: avatarContainerView.bottomAnchor),

            cameraIconView.widthAnchor.constraint(equalToConstant: 56),
            cameraIconView.heightAnchor.constraint(equalToConstant: 56),
            cameraIconView.trailingAnchor.constraint(equalTo: avatarContainerView.trailingAnchor),
            cameraIconView.bottomAnchor.constraint(equalTo: avatarContainerView.bottomAnchor),

            nameLabel.topAnchor.constraint(equalTo: avatarContainerView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            positionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            positionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            addressLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 50),

            toggleNameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toggleNameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toggleNameButton.bottomAnchor.constraint(equalTo: editButton.topAnchor, constant: -12),
            toggleNameButton.heightAnchor.constraint(equalToConstant: 50),

            copyAddressButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            copyAddressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            copyAddressButton.bottomAnchor.constraint(equalTo: toggleNameButton.topAnchor, constant: -12),
            copyAddressButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func getDisplayName() -> String {
        if isShowingFullName {
            return "\(lastName) \(firstName) \(middleName)"
        } else {
            return firstName
        }
    }
    
    @objc private func toggleNameButtonTapped() {
        isShowingFullName.toggle()
        nameLabel.text = getDisplayName()
        
        if isShowingFullName {
            toggleNameButton.setTitle("Показать только имя", for: .normal)
        } else {
            toggleNameButton.setTitle("Показать полное имя", for: .normal)
        }
    }
    
    @objc private func copyAddressButtonTapped() {
        UIPasteboard.general.string = address
    }

    // MARK: - Camera / Image picker

    @objc private func cameraIconTapped() {
        let alert = UIAlertController(title: "Выберите изображение профиля", message: nil, preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            alert.addAction(UIAlertAction(title: "Установить из галереи", style: .default) { [weak self] _ in
                self?.presentImagePicker(sourceType: .photoLibrary)
            })
        }

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Сделать фото", style: .default) { [weak self] _ in
                self?.presentImagePicker(sourceType: .camera)
            })
        }

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        alert.modalPresentationStyle = .overFullScreen

        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
            imageView.tintColor = nil
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
            imageView.tintColor = nil
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
