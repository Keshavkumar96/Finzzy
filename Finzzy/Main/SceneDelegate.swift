//
//  SceneDelegate.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: FZAppCoordinator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowscene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowscene)
        window?.makeKeyAndVisible()
        
        if let window {
            appCoordinator = FZAppCoordinator(window: window)
            appCoordinator?.start()
        }
    }
}
