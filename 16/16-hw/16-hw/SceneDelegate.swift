//
//  SceneDelegate.swift
//  16-hw
//
//  Created by user on 11/19/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    
    let tabBarController = UITabBarController()
    tabBarController.viewControllers = [
      UINavigationController(rootViewController: ViewController()),
      UINavigationController(rootViewController: SecondViewController())
    ]
    tabBarController.viewControllers?.enumerated().forEach { index, controller in
      if index == 0 {
        controller.tabBarItem.image = UIImage(systemName: "person")
        controller.tabBarItem.title = "List"
      }
      if index == 1 {
        controller.tabBarItem.image = UIImage(systemName: "person")
        controller.tabBarItem.title = "Table"
      }
    }
    
    window?.rootViewController = tabBarController
    window?.makeKeyAndVisible()
  }

  func sceneDidDisconnect(_ scene: UIScene) {
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
  }

  func sceneWillResignActive(_ scene: UIScene) {
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
  }
}
