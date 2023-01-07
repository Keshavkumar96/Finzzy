//
//  String+Extension.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

extension String {
    var currencySymbol: String {
        FZCurrency.shared.findSymbol(currencyCode: self)
    }
}
