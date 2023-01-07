//
//  FZNavigationCoordinator.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

protocol FZNavigationCoordinator: AnyObject {
    init(navigationController: UINavigationController)
    
    func start<T: Any>(data: T?)
    func start()
}

extension FZNavigationCoordinator {
    func start<T: Any>(data: T?) { }
    func start() { }
}

extension FZNavigationCoordinator {
    func popViewController(_ viewController: UIViewController) {
        viewController.navigationController?.popViewController(animated: true)
    }
    
    func dismissViewController(_ viewController: UIViewController) {
        viewController.dismiss(animated: true)
    }
}
