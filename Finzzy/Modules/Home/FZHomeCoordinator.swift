//
//  FZHomeCoordinator.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

final class FZHomeCoordinator: FZNavigationCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkManager = FZNetworkManager.shared
        let transactionService = FZTransactionService(networkManager: networkManager)
        let viewModel = FZHomeViewModel(transactionService: transactionService)
        let viewController = FZHomeViewController(viewModel: viewModel, coordinator: self)
        navigationController.viewControllers = [viewController]
    }
    
    func navigateToHomeDetailsPage(data: Card) {
        let homeDetailCoordinator = FZHomeDetailCoordinator(navigationController: navigationController)
        homeDetailCoordinator.start(data: data)
    }
}
