//
//  _3App.swift
//  13
//
//  Created by user on 11/7/25.
//

import SwiftUI

@main
struct _3App: App {
    var body: some Scene {
        WindowGroup {
            ViewControllerWrapper()
        }
    }
}

struct ViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        UserProfileViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
