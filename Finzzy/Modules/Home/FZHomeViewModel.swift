//
//  FZHomeViewModel.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

final class FZHomeViewModel {
    // MARK: - PROPERITIES
    lazy var balanceAmount: String? = {
        let balance = totalTransactionData?.record.balance
        if let balance {
            return balance.amount.description
        }
        return nil
    }()
    
    lazy var currencySymbol: String = {
        totalTransactionData?.record.balance.currency.currencySymbol ?? ""
    }()
    
    private var totalTransactionData: FZTotalTransactions?
    private let transactionService: FZTransactionServiceProtocol
   
    // MARK: - INITIALIZER
    init(transactionService: FZTransactionServiceProtocol) {
        self.transactionService = transactionService
    }
    
    // MARK: - HELPER METHOD
    func fetchTransactionData() async {
        do {
            totalTransactionData = try await transactionService.fetchTransactionData()
        } catch {
            print(error)
        }
    }
}

// MARK: - PROTOCOL CONFORMANCE
extension FZHomeViewModel: FZTransactionCollectionViewDataSource {
    func numberOfItems() -> Int {
        totalTransactionData?.record.cards.count ?? 0
    }
    
    func data(for index: Int) -> Card? {
        totalTransactionData?.record.cards[index]
    }
}
