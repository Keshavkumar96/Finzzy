//
//  FZTransactionDetailTableViewCell.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

final class FZTransactionDetailTableViewCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var priceLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        title.textColor = .darkGray
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        build()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configData(data: Transaction) {
        priceLabel.text = data.cost.currency.currencySymbol + data.cost.amount.description
        
        let firstAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .regular),
            .foregroundColor: UIColor.darkGray
        ]
        let secondAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor.black
        ]
        let firstString = NSMutableAttributedString(
            string: "\(data.name)\n",
            attributes: firstAttribute
        )
        let secondString = NSAttributedString(
            string: data.category,
            attributes: secondAttribute
        )
      
        firstString.append(secondString)
        titleLabel.attributedText = firstString
    }
}

private extension FZTransactionDetailTableViewCell {
    func build() {
        buildHeirarchy()
        buildConstraints()
        additionalSetup()
    }
    
    func buildHeirarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    func buildConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: FZSpacing.medium),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: FZSpacing.medium),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -FZSpacing.small)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -FZSpacing.medium)
        ])
    }
    
    func additionalSetup() {
        backgroundColor = .clear
        selectionStyle = .none
    }
}
