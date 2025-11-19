//
//  ViewController.swift
//  NavigationDemo
//
//  Created by user on 11/19/25.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemMint
    
    view.backgroundColor = .systemGray2
    tabBarItem.title = "Third 3d"
    navigationItem.title = "Third title"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(title: "Button31", style: .prominent, target: self, action: #selector(didTapSmthButton)),
      UIBarButtonItem(title: "Button41", style: .prominent, target: self, action: #selector(didTapSmthButton))
    ]
    navigationItem.leftBarButtonItems = [
      UIBarButtonItem(title: "Button11", style: .plain, target: self, action: #selector(didTapSmthButton))
    ]
  }
  
  @objc func didTapSmthButton() {
    let vc = BlueViewController()
    navigationController?.pushViewController(vc, animated: true)
  }

}

