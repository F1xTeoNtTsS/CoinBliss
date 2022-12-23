//
//  TransactionCell.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 22/12/2022.
//

import UIKit

final class TransactionCell: UICollectionViewCell {
    static let cellId = "TransactionCell"
    
    let sumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 20)
        return label
    }()
    
    let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        return separatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ transaction: Transaction) {
        self.sumLabel.text = String(transaction.sum)
        setViewsLayout()
    }
    
    private func setViewsLayout() {
        let views = [self.sumLabel, self.separatorView]
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            self.sumLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor),
            self.sumLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.sumLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
}
