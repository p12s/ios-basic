//
//  SecondViewController.swift
//  NavigationDemo
//
//  Created by user on 11/19/25.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
      view.backgroundColor = .systemBlue
      tabBarItem.title = "Second"
      navigationItem.title = "Second title"
      navigationController?.navigationBar.prefersLargeTitles = false
    }
  
}
