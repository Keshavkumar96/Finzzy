//
//  FZHomeDetailViewController.swift
//  Finzzy
//
//  Created by keshavkumar A C on 07/01/23.
//

import UIKit

final class FZHomeDetailViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.text = viewModel.title
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor(hexString: viewModel.cardBorderColor).cgColor
        view.backgroundColor = UIColor(hexString: viewModel.cardColor)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = .systemGroupedBackground.withAlphaComponent(0.5)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let viewModel: FZHomeDetailViewModel
    private let coordinator: FZHomeDetailCoordinator
    
    init(viewModel: FZHomeDetailViewModel, coordinator: FZHomeDetailCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
}

private extension FZHomeDetailViewController {
    func buildUI() {
        buildHeirarchy()
        buildConstraints()
        additionalSetup()
    }
    
    func buildHeirarchy() {
        view.addSubview(titleLabel)
        view.addSubview(cardView)
        view.addSubview(tableView)
    }
    
    func buildConstraints() {
        titleLabelConstraints()
        cardViewConstraints()
        tableViewConstraints()
    }
    
    func additionalSetup() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        registerCells()
    }
    
    func registerCells() {
        tableView.register(cell: FZTransactionDetailTableViewCell.self)
    }
    
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: FZSpacing.medium
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: FZSpacing.medium
            ),
            titleLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 60)
        ])
    }
    
    func cardViewConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: FZSpacing.medium
            ),
            cardView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: FZSpacing.medium + FZSpacing.extraSmall
            ),
            cardView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -(FZSpacing.medium + FZSpacing.extraSmall)
            ),
            cardView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.25)
        ])
    }
    
    func tableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: cardView.bottomAnchor,
                constant: FZSpacing.large
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: FZSpacing.none
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: FZSpacing.none
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: FZSpacing.none
            )
        ])
    }
}

extension FZHomeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: FZTransactionDetailTableViewCell.self, for: indexPath)
        cell.configData(data: viewModel.data(for: indexPath.row))
        return cell
    }
}
