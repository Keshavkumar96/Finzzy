//
//  FZViewController.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

class FZHomeViewController: UIViewController {
    private let viewModel: FZHomeViewModel
    
    init(viewModel: FZHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        Task {
            await viewModel.fetchTransactionData()
        }
    }
}
