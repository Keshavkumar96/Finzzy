//
//  FZHomeViewModel.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

final class FZHomeViewModel {
    private var totalTransactionData: FZTotalTransactions?
    let transactionService: FZTransactionServiceProtocol
    
    init(transactionService: FZTransactionServiceProtocol) {
        self.transactionService = transactionService
    }
    
    func fetchTransactionData() async {
        do {
            totalTransactionData = try await transactionService.fetchTransactionData()
        } catch {
            print(error)
        }
    }
}
