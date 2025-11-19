//
//  UserRepository.swift
//  16-hw
//
//  Created by user on 11/19/25.
//

import UIKit

final class UserRepository {
  
  static let shared = UserRepository()
  
  private var users: [User] = []
  
  private init() {
    users = [
      User(
        firstName: "Иван",
        lastName: "Иванов",
        middleName: "Иванович",
        position: "iOS-разработчик",
        address: "г. Москва, ул. Ленина, д. 1"
      ),
      User(
        firstName: "Мария",
        lastName: "Петрова",
        middleName: "Петровна",
        position: "Android-разработчик",
        address: "г. Санкт-Петербург, пр. Невский, д. 25"
      ),
      User(
        firstName: "Алексей",
        lastName: "Сидоров",
        middleName: "Петрович",
        position: "Backend-разработчик",
        address: "г. Казань, ул. Баумана, д. 10"
      ),
      User(
        firstName: "Елена",
        lastName: "Козлова",
        middleName: "Игоревна",
        position: "UI/UX дизайнер",
        address: "г. Новосибирск, ул. Красный проспект, д. 5"
      )
    ]
  }
  
  func getUsers() -> [User] {
    return users
  }
  
  func updateUser(_ user: User) {
    if let index = users.firstIndex(where: {
      $0.firstName == user.firstName &&
      $0.lastName == user.lastName &&
      $0.middleName == user.middleName
    }) {
      users[index] = user
    }
  }
}

