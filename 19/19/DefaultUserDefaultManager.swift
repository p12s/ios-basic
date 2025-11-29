//
//  DefaultFileManager.swift
//  19
//
//  Created by user on 11/29/25.
//

import Foundation

final class DefaultUserDefaultManager: FileSystemProtocol {
  enum Keys: String {
    case creds = "creds"
  }
  private let userDefaults: UserDefaults = .standard
  private lazy var encoder: JSONEncoder = {
    JSONEncoder()
  }()
  private lazy var decoder: JSONDecoder = {
    JSONDecoder()
  }()
  
  func save(creds: Creds) {
    do {
      let data = try encoder.encode(creds)
      userDefaults.set(data, forKey: Keys.creds.rawValue)
      print("user defaults saved")
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func load() -> Creds? {
    guard let data = userDefaults.data(forKey: Keys.creds.rawValue) else {
      return nil
    }
      
    do {
      let creds = try decoder.decode(Creds.self, from: data)
      print("user defaults loaded")
      return creds
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
  
  func delete() {
    userDefaults.removeObject(forKey: Keys.creds.rawValue)
  }
  
}
