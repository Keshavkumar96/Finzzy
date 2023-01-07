//
//  FZHomeDetailViewModel.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

final class FZHomeDetailViewModel {
    private let cardData: Card
    
    lazy var title: String = {
        cardData.name
    }()
    
    lazy var cardBorderColor: String = {
        cardData.cardBorderColor
    }()
    
    lazy var cardColor: String = {
        cardData.colour
    }()
    
    init(data: Card) {
        self.cardData = data
    }
    
}

extension FZHomeDetailViewModel {
    func numberOfItems() -> Int {
        cardData.transactions.count
    }
    
    func data(for index: Int) -> Transaction {
        cardData.transactions[index]
    }
    
}
