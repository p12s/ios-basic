//
//  DefaultFileManager.swift
//  19
//
//  Created by user on 11/29/25.
//

import Foundation

final class DefaultFileManager: FileSystemProtocol {
  private let fileManager: FileManager = .default
  private lazy var encoder: JSONEncoder = {
    JSONEncoder()
  }()
  private lazy var decoder: JSONDecoder = {
    JSONDecoder()
  }()
  
  func save(creds: Creds) {
    guard let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return
    }
    let fileURL = docs.appendingPathComponent("login.json")
    do {
      let data = try encoder.encode(creds)
      try data.write(to: fileURL)
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func load() -> Creds? {
    guard let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return nil
    }
    let fileURL = docs.appendingPathComponent("login.json")
    do {
      let data = try Data(contentsOf: fileURL)
      let creds = try decoder.decode(Creds.self, from: data)
      return creds
    } catch {
      print(error.localizedDescription)
      return nil
    }
  }
  
  func delete() {
    guard let docs = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return
    }
    let fileURL = docs.appendingPathComponent("login.json")
    do {
      try fileManager.removeItem(at: fileURL)
    } catch {
      print(error.localizedDescription)
    }
  }
  
}
