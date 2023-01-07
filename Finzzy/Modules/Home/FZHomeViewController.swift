//
//  FZViewController.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

final class FZHomeViewController: UIViewController {
    // MARK: - PROPERITIES
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = FZHomeConstants.myCards.rawValue
        label.textColor = .black
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: FZHomeAssets.profile.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var collectionView: FZTransactionCollectionView = {
        let collectionView = FZTransactionCollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.viewDelegate = self
        collectionView.viewDataSource = viewModel
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let viewModel: FZHomeViewModel
    private let coordinator: FZHomeCoordinator
    
    // MARK: - INITIALIZER
    init(viewModel: FZHomeViewModel, coordinator: FZHomeCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VC LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        getData()
    }
}

// MARK: - PRIVATE - HELPER METHODS
private extension FZHomeViewController {
    func getData() {
        Task {
            await viewModel.fetchTransactionData()
            await MainActor.run {
                collectionView.reloadData()
                balanceLabelConfig(currency: viewModel.currencySymbol, amount: viewModel.balanceAmount ?? "")
            }
        }
    }
}

// MARK: - PRIVATE - UI BUILDER METHODS
private extension FZHomeViewController {
    func buildUI() {
        buildHeirarchy()
        buildConstraints()
        additionalSetup()
    }
    
    func buildHeirarchy() {
        view.addSubview(profileImageView)
        view.addSubview(titleLabel)
        view.addSubview(balanceLabel)
        view.addSubview(collectionView)
    }
    
    func buildConstraints() {
        profileImageViewConstraints()
        titleLabelConstraints()
        balanceLabelConstraints()
        collectionViewConstraints()
    }
    
    func additionalSetup() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }
    
    func balanceLabelConfig(currency: String, amount: String) {
        let firstAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.gray
        ]
        let secondAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 30, weight: .bold),
            .foregroundColor: UIColor.lightGray,
            .kern: 1
        ]
        let firstString = NSMutableAttributedString(
            string: "\(FZHomeConstants.balance.rawValue)\n",
            attributes: firstAttribute
        )
        let secondString = NSAttributedString(
            string: "\(currency)\(amount)",
            attributes: secondAttribute
        )
        firstString.append(secondString)
        balanceLabel.attributedText = firstString
    }
    
    func profileImageViewConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: FZSpacing.large
            ),
            profileImageView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -FZSpacing.medium
            ),
            profileImageView.widthAnchor.constraint(
                equalToConstant: FZSpacing.extraLarge
            ),
            profileImageView.heightAnchor.constraint(
                equalToConstant: FZSpacing.extraLarge
            )
        ])
    }
    
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: FZSpacing.large
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: FZSpacing.medium
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: profileImageView.leadingAnchor,
                constant: -FZSpacing.medium
            )
        ])
    }
    
    
    func collectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo: balanceLabel.bottomAnchor,
                constant: FZSpacing.extraExtraLarge
            ),
            collectionView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: FZSpacing.none
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: FZSpacing.none
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -FZSpacing.medium
            )
        ])
    }
    
    func balanceLabelConstraints() {
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: FZSpacing.extraLarge
            ),
            balanceLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: FZSpacing.medium
            ),
            balanceLabel.trailingAnchor.constraint(
                equalTo: profileImageView.leadingAnchor,
                constant: -FZSpacing.medium
            )
        ])
    }
}

extension FZHomeViewController: FZTransactionCollectionViewDelegate {
    func didSelectItem(at index: Int) {
        if let card = viewModel.data(for: index) {
            coordinator.navigateToHomeDetailsPage(data: card)
        }
    }
}
