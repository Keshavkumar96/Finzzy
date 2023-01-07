//
//  FZTransactionCollectionView.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

protocol FZTransactionCollectionViewDataSource {
    func numberOfItems() -> Int
    func data(for index: Int) -> Card?
}

protocol FZTransactionCollectionViewDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

final class FZTransactionCollectionView: UICollectionView {
    // MARK: - PROPERITIES
    private var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = FZSpacing.medium
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    var viewDataSource: FZTransactionCollectionViewDataSource?
    weak var viewDelegate: FZTransactionCollectionViewDelegate?
    
    // MARK: - INITIALIZER
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PRIVATE METHODS
private extension FZTransactionCollectionView {
    func setup() {
        delegate = self
        dataSource = self
        collectionViewLayout = layout
        backgroundColor = .white
        registerCell()
        showsHorizontalScrollIndicator = false
        contentInset = .init(
            top: FZSpacing.medium,
            left: FZSpacing.medium,
            bottom: FZSpacing.medium,
            right: FZSpacing.medium
        )
    }
    
    func registerCell() {
        register(cell: FZTransactionCardCollectionViewCell.self)
    }
}

// MARK: - UICOLLECTIONVIEW DATASOURCE, DELEGATE
extension FZTransactionCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewDataSource?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = viewDataSource,
              let data = dataSource.data(for: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(
            type: FZTransactionCardCollectionViewCell.self,
            for: indexPath
        )
        cell.tag = indexPath.row
        cell.configUI(
            backgroundColor: UIColor(hexString: data.colour),
            borderColor: UIColor(hexString: data.cardBorderColor).cgColor
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewDelegate?.didSelectItem(at: indexPath.row)
    }
}

// MARK: - UICOLLECTIONVIEW DELEGATE FLOW LAYOUT
extension FZTransactionCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: collectionView.frame.width * 0.75,
            height: collectionView.frame.height * 0.90
        )
    }
}
