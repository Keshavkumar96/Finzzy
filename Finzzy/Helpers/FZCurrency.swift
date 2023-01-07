//
//  FZCurrency.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

final class FZCurrency {
    static let shared: FZCurrency = FZCurrency()

    // Acts as a storage to retrieve the symbols that was found already
    private var cache: [String: String] = [:]
    
    private init() { }
    
    /// Finds currency symbol and stores it in cache
    /// - Parameter currencyCode: currency Code
    /// - Returns: currency symbol
    func findSymbol(currencyCode:String) -> String {
        if let hit = cache[currencyCode] { return hit }
        
        guard currencyCode.count < 4 else { return "" }

        let symbol = findSymbolBy(currencyCode)
        cache[currencyCode] = symbol

        return symbol
    }

    private func findSymbolBy(_ currencyCode: String) -> String {
        var candidates: [String] = []
        let locales = NSLocale.availableLocaleIdentifiers

        for localeId in locales {
            guard let symbol = findSymbolBy(localeId, currencyCode) else { continue }
            if symbol.count == 1 { return symbol }
            candidates.append(symbol)
        }

        return candidates.sorted(by: { $0.count < $1.count }).first ?? ""
    }

    private func findSymbolBy(_ localeId: String, _ currencyCode: String) -> String? {
        let locale = Locale(identifier: localeId)
        return currencyCode.caseInsensitiveCompare(locale.currency?.identifier ?? "") == .orderedSame ?
            locale.currencySymbol : nil
    }
}
