//
//  FZTransactionService.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

protocol FZTransactionServiceProtocol {
    func fetchTransactionData() async throws -> FZTotalTransactions?
}

final class FZTransactionService: FZBaseService, FZTransactionServiceProtocol {
    /// Fetches all transactions from the api
    /// - Throws: API Error
    /// - Returns: FZTotalTransactions
    func fetchTransactionData() async throws -> FZTotalTransactions? {
        do {
            return try await networkManager.makeAPICall(
                urlRequest: FZEndPoints.transaction.urlRequest(),
                modal: FZTotalTransactions.self
            )
        } catch {
            throw error
        }
    }
}
