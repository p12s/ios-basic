//
//  SceneDelegate.swift
//  NavigationDemo
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
      ViewController(),
      SecondViewController(),
      UINavigationController(rootViewController: ThirdViewController())
    ]
    tabBarController.viewControllers?.enumerated().forEach { index, controller in
      if index == 0 {
        controller.tabBarItem.image = UIImage(systemName: "house")
        controller.tabBarItem.title = "First"
        controller.tabBarItem.badgeValue = "2"
      }
      if index == 1 {
        controller.tabBarItem.image = UIImage(systemName: "person")
      }
      if index == 2 {
        controller.tabBarItem.image = UIImage(systemName: "star")
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

