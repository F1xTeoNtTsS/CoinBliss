//
//  MultiplyTransactionCell.swift.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import UIKit

final class MultiplyTransactionCell: UICollectionViewCell {
    static let cellId = "MultiplyTransactionCell"
    
    private let transactionsVC = TransactionsController(mode: .small)
    
    func setup(_ transactions: [Transaction]) {
        self.transactionsVC.transactions = transactions
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = Resources.Colors.cellMainColor
        self.contentView.layer.cornerRadius = 10
        
        self.setDefaultShadow()
        setViewsLayout()
        
        self.transactionsVC.view.isUserInteractionEnabled = false
    }
    
    private func setViewsLayout() {
        self.addSubview(transactionsVC.view)
        transactionsVC.view.translatesAutoresizingMaskIntoConstraints = false
        transactionsVC.view.layer.cornerRadius = 10
        transactionsVC.view.clipsToBounds = true

        NSLayoutConstraint.activate([
            transactionsVC.view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            transactionsVC.view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            transactionsVC.view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            transactionsVC.view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
