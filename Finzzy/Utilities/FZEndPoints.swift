//
//  FZEndPoints.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

enum FZEndPoints: String {
    case transaction
    
    private var url: String {
        switch self {
        case .transaction: return "https://api.jsonbin.io/v3/b/63b7e92b15ab31599e2ea89f"
        }
    }
    
    func urlRequest() throws -> URLRequest {
        switch self {
        case .transaction:
            do {
                return try URLRequest(url: url, method: .get)
            } catch {
                throw error
            }
        }
    }
}
