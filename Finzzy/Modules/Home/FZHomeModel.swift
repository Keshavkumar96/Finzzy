//
//  TransactionModel.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

// MARK: - FZTotalTransactions
struct FZTotalTransactions: Codable {
    let record: Record
}

// MARK: - Record
struct Record: Codable {
    let avatar: String
    let balance: Balance
    let cards: [Card]
}

// MARK: - Balance
struct Balance: Codable {
    let amount: Double
    let currency: String
}

// MARK: - Card
struct Card: Codable {
    let name, colour, cardBorderColor: String
    let transactions: [Transaction]

    enum CodingKeys: String, CodingKey {
        case name, colour
        case cardBorderColor = "card_border_color"
        case transactions
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let category: String
    let cost: Balance
    let name: String
}
