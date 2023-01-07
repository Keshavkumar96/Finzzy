//
//  FZImageLoader.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

protocol FZImageLoader: RawRepresentable where RawValue == String {
    var image: UIImage { get }
    var templateImage: UIImage? { get }
    var originalImage: UIImage? { get }
}

extension FZImageLoader {
    var image: UIImage {
        UIImage(
            named: rawValue,
            in: .main,
            with: .none
        ) ?? UIImage()
    }
    
    var templateImage: UIImage? {
        image.withRenderingMode(.alwaysTemplate)
    }
    
    var originalImage: UIImage? {
        image.withRenderingMode(.alwaysOriginal)
    }
}
