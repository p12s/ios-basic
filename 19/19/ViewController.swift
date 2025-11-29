//
//  ViewController.swift
//  19
//
//  Created by user on 11/29/25.
//

import UIKit

class ViewController: UIViewController, MainViewDelegate {
  
  private lazy var mainView: MainView = {
    let view = MainView()
    view.delegate = self
    return view
  }()
  
  private var fileSystemManager: FileSystemProtocol
  
  init(fileSystemManager: FileSystemProtocol) {
    self.fileSystemManager = fileSystemManager
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func loadView() {
    self.view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    load()
  }
  
  func save(login: String, pass: String) {
    let creds = Creds(login: login, pass: pass)
    fileSystemManager.save(creds: creds)
  }
  
  func load() {
    guard let creds = fileSystemManager.load() else {
      print("No data")
      return
    }
    print("Login: \(creds.login), Password: \(creds.pass)")
    mainView.setupData(creds)
  }
  
  func delete() {
    fileSystemManager.delete()
  }
}

