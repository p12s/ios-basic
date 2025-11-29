//
//  FileSystemProtocol.swift
//  19
//
//  Created by user on 11/29/25.
//

protocol FileSystemProtocol {
  func save(creds: Creds)
  func load() -> Creds?
  func delete()
}
