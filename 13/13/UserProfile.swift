//
//  UserProfileViewController.swift
//  13
//
//  Created by user on 11/7/25.
//

import UIKit

class UserProfileViewController: UIViewController {
    private let contentView = UserProfileView()

    private let lastName = "Иванов"
    private let firstName = "Иван"
    private let middleName = "Иванович"
    private let position = "iOS-разработчик"
    private let address = "г. Москва, ул. Ленина, д. 1"
    
    private var isShowingFullName = true

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        applyViewState()
    }

    private func getDisplayName() -> String {
        if isShowingFullName {
            return "\(lastName) \(firstName) \(middleName)"
        } else {
            return firstName
        }
    }
    
    private func applyViewState() {
        let state = UserProfileView.ViewState(
            name: getDisplayName(),
            positionText: makePositionText(),
            address: address,
            isShowingFullName: isShowingFullName
        )
        contentView.apply(state)
    }

    private func makePositionText() -> NSAttributedString {
        let attachment = NSTextAttachment()
        if let icon = UIImage(systemName: "person")?.withTintColor(.secondaryLabel) {
            attachment.image = icon
        }
        let imageString = NSAttributedString(attachment: attachment)
        let result = NSMutableAttributedString()
        result.append(imageString)
        result.append(NSAttributedString(string: " \(position)"))
        return result
    }

    private func presentAvatarOptions() {
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

}

// MARK: - UIImagePickerControllerDelegate

extension UserProfileViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            contentView.updateAvatarImage(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.updateAvatarImage(originalImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension UserProfileViewController: UINavigationControllerDelegate {}

extension UserProfileViewController: UserProfileViewDelegate {
    func userProfileViewDidTapToggleName(_ view: UserProfileView) {
        isShowingFullName.toggle()
        applyViewState()
    }

    func userProfileViewDidTapCopyAddress(_ view: UserProfileView) {
        UIPasteboard.general.string = address
    }

    func userProfileViewDidTapCamera(_ view: UserProfileView) {
        presentAvatarOptions()
    }

    func userProfileViewDidTapEdit(_ view: UserProfileView) {
    }
}

