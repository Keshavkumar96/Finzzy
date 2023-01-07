//
//  FZHomeDetailCoordinator.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

final class FZHomeDetailCoordinator: FZNavigationCoordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start<T>(data: T?) {
        guard let cardData = data as? Card else { return }
        
        let viewModel = FZHomeDetailViewModel(data: cardData)
        let viewController = FZHomeDetailViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
