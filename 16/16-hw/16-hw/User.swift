//
//  User.swift
//  16-hw
//
//  Created by user on 11/19/25.
//

import UIKit

struct User {
  let firstName: String
  let lastName: String
  let middleName: String
  let position: String
  let address: String
  let avatarImage: UIImage?
  
  init(firstName: String, lastName: String, middleName: String, position: String, address: String, avatarImage: UIImage? = nil) {
    self.firstName = firstName
    self.lastName = lastName
    self.middleName = middleName
    self.position = position
    self.address = address
    self.avatarImage = avatarImage
  }
  
  func withAvatarImage(_ image: UIImage?) -> User {
    return User(
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      position: position,
      address: address,
      avatarImage: image
    )
  }
}

