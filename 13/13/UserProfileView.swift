import UIKit

protocol UserProfileViewDelegate: AnyObject {
    func userProfileViewDidTapToggleName(_ view: UserProfileView)
    func userProfileViewDidTapCopyAddress(_ view: UserProfileView)
    func userProfileViewDidTapCamera(_ view: UserProfileView)
    func userProfileViewDidTapEdit(_ view: UserProfileView)
}

final class UserProfileView: UIView {
    struct ViewState {
        let name: String
        let positionText: NSAttributedString
        let address: String
        let isShowingFullName: Bool
    }

    weak var delegate: UserProfileViewDelegate?

    private lazy var avatarContainerView = UIView()
    private lazy var imageView = UIImageView()
    private lazy var cameraIconView = UIImageView()
    private lazy var nameLabel = UILabel()
    private lazy var positionLabel = UILabel()
    private lazy var addressLabel = UILabel()
    private lazy var editButton = UIButton(type: .system)
    private lazy var toggleNameButton = UIButton(type: .system)
    private lazy var copyAddressButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarContainerView.layer.cornerRadius = 30
        avatarContainerView.clipsToBounds = true
        cameraIconView.layer.cornerRadius = 30
    }

    func apply(_ state: ViewState) {
        nameLabel.text = state.name
        positionLabel.attributedText = state.positionText
        addressLabel.text = state.address
        let toggleTitle = state.isShowingFullName ? "Показать только имя" : "Показать полное имя"
        toggleNameButton.setTitle(toggleTitle, for: .normal)
    }

    func updateAvatarImage(_ image: UIImage?) {
        if let image {
            imageView.image = image
            imageView.tintColor = nil
        } else {
            imageView.image = UIImage(systemName: "person.fill")
            imageView.tintColor = .systemGray3
        }
    }

    private func setup() {
        backgroundColor = .systemBackground
        avatarContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarContainerView)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainerView.addSubview(imageView)
        updateAvatarImage(nil)

        cameraIconView.image = UIImage(systemName: "camera.fill")
        cameraIconView.tintColor = .white
        cameraIconView.backgroundColor = .systemBlue
        cameraIconView.contentMode = .center
        cameraIconView.isUserInteractionEnabled = true
        cameraIconView.translatesAutoresizingMaskIntoConstraints = false
        avatarContainerView.addSubview(cameraIconView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCameraTap))
        cameraIconView.addGestureRecognizer(tapGesture)

        nameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)

        toggleNameButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        toggleNameButton.setTitleColor(.white, for: .normal)
        toggleNameButton.backgroundColor = .systemBlue
        toggleNameButton.layer.cornerRadius = 12
        toggleNameButton.layer.borderWidth = 1
        toggleNameButton.layer.borderColor = UIColor.systemBlue.cgColor
        toggleNameButton.addTarget(self, action: #selector(handleToggleName), for: .touchUpInside)
        toggleNameButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(toggleNameButton)

        positionLabel.font = .systemFont(ofSize: 16)
        positionLabel.textColor = .secondaryLabel
        positionLabel.textAlignment = .left
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(positionLabel)

        addressLabel.font = .systemFont(ofSize: 16)
        addressLabel.textColor = .secondaryLabel
        addressLabel.textAlignment = .left
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addressLabel)

        editButton.setTitle("Редактировать", for: .normal)
        editButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        editButton.setTitleColor(.white, for: .normal)
        editButton.backgroundColor = .systemBlue
        editButton.layer.cornerRadius = 12
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor.systemBlue.cgColor
        editButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(editButton)

        copyAddressButton.setTitle("Копировать адрес", for: .normal)
        copyAddressButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        copyAddressButton.setTitleColor(.white, for: .normal)
        copyAddressButton.backgroundColor = .systemBlue
        copyAddressButton.layer.cornerRadius = 12
        copyAddressButton.layer.borderWidth = 1
        copyAddressButton.layer.borderColor = UIColor.systemBlue.cgColor
        copyAddressButton.addTarget(self, action: #selector(handleCopyAddress), for: .touchUpInside)
        copyAddressButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(copyAddressButton)

        NSLayoutConstraint.activate([
            avatarContainerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            avatarContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            avatarContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
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
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            positionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            addressLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            editButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            editButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            editButton.heightAnchor.constraint(equalToConstant: 50),

            toggleNameButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            toggleNameButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            toggleNameButton.bottomAnchor.constraint(equalTo: editButton.topAnchor, constant: -12),
            toggleNameButton.heightAnchor.constraint(equalToConstant: 50),

            copyAddressButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            copyAddressButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            copyAddressButton.bottomAnchor.constraint(equalTo: toggleNameButton.topAnchor, constant: -12),
            copyAddressButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func handleToggleName() {
        delegate?.userProfileViewDidTapToggleName(self)
    }

    @objc private func handleCopyAddress() {
        delegate?.userProfileViewDidTapCopyAddress(self)
    }

    @objc private func handleCameraTap() {
        delegate?.userProfileViewDidTapCamera(self)
    }

    @objc private func handleEdit() {
        delegate?.userProfileViewDidTapEdit(self)
    }
}

