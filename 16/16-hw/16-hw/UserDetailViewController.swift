import UIKit

protocol UserDetailViewControllerDelegate: AnyObject {
    func userDetailViewController(_ controller: UserDetailViewController, didUpdateUser user: User)
}

class UserDetailViewController: UIViewController {
    var user: User?
    weak var delegate: UserDetailViewControllerDelegate?
    
    private let contentView = UserDetailView()
    private var isShowingFullName = true

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        contentView.delegate = self
        applyViewState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let updatedUser = user {
            UserRepository.shared.updateUser(updatedUser)
            delegate?.userDetailViewController(self, didUpdateUser: updatedUser)
        }
    }

    private func getDisplayName() -> String {
        guard let user = user else { return "" }
        if isShowingFullName {
            return "\(user.lastName) \(user.firstName) \(user.middleName)"
        } else {
            return user.firstName
        }
    }
    
    private func applyViewState() {
        guard let user = user else { return }
        let state = UserDetailView.ViewState(
            name: getDisplayName(),
            positionText: makePositionText(),
            address: user.address,
            isShowingFullName: isShowingFullName
        )
        contentView.apply(state)
        contentView.updateAvatarImage(user.avatarImage)
    }

    private func makePositionText() -> NSAttributedString {
        guard let user = user else { return NSAttributedString() }
        let attachment = NSTextAttachment()
        if let icon = UIImage(systemName: "person")?.withTintColor(.secondaryLabel) {
            attachment.image = icon
        }
        let imageString = NSAttributedString(attachment: attachment)
        let result = NSMutableAttributedString()
        result.append(imageString)
        result.append(NSAttributedString(string: " \(user.position)"))
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

extension UserDetailViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let image = selectedImage, var currentUser = user {
            currentUser = currentUser.withAvatarImage(image)
            user = currentUser
            contentView.updateAvatarImage(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension UserDetailViewController: UINavigationControllerDelegate {}

extension UserDetailViewController: UserDetailViewDelegate {
    func userDetailViewDidTapToggleName(_ view: UserDetailView) {
        isShowingFullName.toggle()
        applyViewState()
    }

    func userDetailViewDidTapCopyAddress(_ view: UserDetailView) {
        guard let user = user else { return }
        UIPasteboard.general.string = user.address
    }

    func userDetailViewDidTapCamera(_ view: UserDetailView) {
        presentAvatarOptions()
    }

    func userDetailViewDidTapEdit(_ view: UserDetailView) {
    }
}
