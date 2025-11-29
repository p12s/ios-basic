//
//  DefaultKeyChainManager.swift
//  19
//
//  Created by user on 11/29/25.
//

import Foundation
import Security

final class DefaultKeyChainManager: FileSystemProtocol {
  private let service = "com.app.creds"
  private let account = "userCredentials"
  private lazy var encoder: JSONEncoder = {
    JSONEncoder()
  }()
  private lazy var decoder: JSONDecoder = {
    JSONDecoder()
  }()
  
  func save(creds: Creds) {
    delete()
    
    do {
      let data = try encoder.encode(creds)
      let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrService as String: service,
        kSecAttrAccount as String: account,
        kSecValueData as String: data
      ]
      
      let status = SecItemAdd(query as CFDictionary, nil)
      if status == errSecSuccess {
        print("keychain saved")
      } else {
        print("keychain save error: \(status)")
      }
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func load() -> Creds? {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: account,
      kSecReturnData as String: true,
      kSecMatchLimit as String: kSecMatchLimitOne
    ]
    
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    
    guard status == errSecSuccess,
          let data = result as? Data else {
      print("keychain load error: \(status)")
      return nil
    }
    
    do {
      let creds = try decoder.decode(Creds.self, from: data)
      print("keychain loaded")
      return creds
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
  
  func delete() {
    let query: [String: Any] = [
      kSecClass as String: kSecClassGenericPassword,
      kSecAttrService as String: service,
      kSecAttrAccount as String: account
    ]
    
    let status = SecItemDelete(query as CFDictionary)
    if status == errSecSuccess || status == errSecItemNotFound {
      print("keychain deleted")
    } else {
      print("keychain delete error: \(status)")
    }
  }
}

