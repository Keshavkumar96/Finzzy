//
//  FZAppCoordinator.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

final class FZAppCoordinator: FZRootCoordinator {
    private let window: UIWindow
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        let homeCoordinator = FZHomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
    }
}

