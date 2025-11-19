import UIKit

final class UserCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "UserCollectionViewCell"
  
  private lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemBackground
    view.layer.cornerRadius = 12
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    view.layer.shadowOpacity = 0.1
    return view
  }()
  
  private lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 5
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .systemGray5
    imageView.tintColor = .systemGray
    return imageView
  }()
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    label.textColor = .label
    label.textAlignment = .center
    label.numberOfLines = 1
    return label
  }()
  
  private lazy var middleNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 13, weight: .regular)
    label.textColor = .label
    label.textAlignment = .center
    label.numberOfLines = 1
    return label
  }()
  
  private lazy var positionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12, weight: .regular)
    label.textColor = .secondaryLabel
    label.textAlignment = .center
    label.numberOfLines = 2
    return label
  }()
  
  private lazy var addressLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 11, weight: .regular)
    label.textColor = .tertiaryLabel
    label.textAlignment = .center
    label.numberOfLines = 2
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    contentView.addSubview(containerView)
    containerView.addSubview(avatarImageView)
    containerView.addSubview(nameLabel)
    containerView.addSubview(middleNameLabel)
    containerView.addSubview(positionLabel)
    containerView.addSubview(addressLabel)
    
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      avatarImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
      avatarImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      avatarImageView.widthAnchor.constraint(equalToConstant: 62),
      avatarImageView.heightAnchor.constraint(equalToConstant: 62),
      
      nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
      nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
      nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
      
      middleNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
      middleNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
      middleNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
      
      positionLabel.topAnchor.constraint(equalTo: middleNameLabel.bottomAnchor, constant: 4),
      positionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
      positionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
      
      addressLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 4),
      addressLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
      addressLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
      addressLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -16)
    ])
  }
  
  func configure(with user: User) {
    nameLabel.text = "\(user.lastName) \(user.firstName)"
    middleNameLabel.text = user.middleName
    positionLabel.text = user.position
    addressLabel.text = user.address
    avatarImageView.image = user.avatarImage ?? UIImage(systemName: "person.fill")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = nil
    middleNameLabel.text = nil
    positionLabel.text = nil
    addressLabel.text = nil
    avatarImageView.image = nil
  }
}

