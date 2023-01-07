//
//  FZRootCoordinator.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

protocol FZRootCoordinator: AnyObject {
    init(window: UIWindow)
    
    func start<T: Any>(data: T?)
    func start()
}

extension FZRootCoordinator {
    func start<T: Any>(data: T?) { }
    func start() { }
}
