//
//  FZNetworkManager.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation
import Alamofire

/// Protocol that contains functions to make api calls with url request & codable model type
protocol FZNetworkManagerProvider {
    func makeAPICall<T: Decodable>(urlRequest: URLRequest, modal: T.Type ) async throws -> T
}

/// Singleton class that confirms to `FZNetworkManagerProvider` protocol to make api calls with shared URLSession
final class FZNetworkManager {
    let sessionManager: Session = {
        Session(
            configuration: URLSessionConfiguration.af.default
        )
    }()
    
    static let shared = FZNetworkManager()
    
    private init() {}
}

extension FZNetworkManager: FZNetworkManagerProvider {
    /// Makes api call to server
    /// - Throws: API error - 20X, 40X, 50X
    /// - Parameters:
    ///   - urlRequest: URL Request
    ///   - modal: Codable modal type
    /// - Returns: Decoded modal data from api response
    func makeAPICall<T: Decodable>(urlRequest: URLRequest, modal: T.Type ) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            sessionManager.request(urlRequest)
                .validate()
                .responseDecodable(of: modal) { response in
                    switch response.result {
                    case .success:
                        continuation.resume(with: response.result)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
