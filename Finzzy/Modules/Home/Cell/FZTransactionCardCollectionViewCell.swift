//
//  FZTransactionCardCollectionViewCell.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

final class FZTransactionCardCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI(backgroundColor: UIColor, borderColor: CGColor) {
        self.backgroundColor = backgroundColor
        self.layer.borderWidth = 5
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
}
