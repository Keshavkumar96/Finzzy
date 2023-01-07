//
//  FZBaseService.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import Foundation

/// Parent class that has networkManager to help it's child classes inherit the same & use it.
class FZBaseService {
    var networkManager: FZNetworkManagerProvider
    
    init(networkManager: FZNetworkManagerProvider) {
        self.networkManager = networkManager
    }
}
