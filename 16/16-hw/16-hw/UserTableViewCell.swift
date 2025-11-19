//
//  UserTableViewCell.swift
//  16-hw
//
//  Created by user on 11/19/25.
//

import UIKit

final class UserTableViewCell: UITableViewCell {
  
  static let identifier = "UserTableViewCell"
  
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
    label.font = .systemFont(ofSize: 16, weight: .semibold)
    label.textColor = .label
    return label
  }()
  
  private lazy var positionLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 14, weight: .regular)
    label.textColor = .secondaryLabel
    return label
  }()
  
  private lazy var addressLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 13, weight: .regular)
    label.textColor = .tertiaryLabel
    label.numberOfLines = 0
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    contentView.addSubview(avatarImageView)
    contentView.addSubview(nameLabel)
    contentView.addSubview(positionLabel)
    contentView.addSubview(addressLabel)
    
    NSLayoutConstraint.activate([
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      avatarImageView.widthAnchor.constraint(equalToConstant: 62),
      avatarImageView.heightAnchor.constraint(equalToConstant: 62),
      
      nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      positionLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
      positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
      positionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      addressLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
      addressLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 4),
      addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      addressLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
    ])
  }
  
  func configure(with user: User) {
    nameLabel.text = "\(user.lastName) \(user.firstName) \(user.middleName)"
    positionLabel.text = user.position
    addressLabel.text = user.address
    avatarImageView.image = user.avatarImage ?? UIImage(systemName: "person.fill")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    nameLabel.text = nil
    positionLabel.text = nil
    addressLabel.text = nil
    avatarImageView.image = nil
  }
}
