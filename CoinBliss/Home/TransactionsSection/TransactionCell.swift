//
//  TransactionCell.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 22/12/2022.
//

import UIKit

final class TransactionCell: UICollectionViewCell, HomeCellProtocol {
    static let cellId = "TransactionCell"
    
    let categoryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Resources.Colors.titleColor
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 18)
        return label
    }()
    
    let periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 14)
        return label
    }()
    
    let sumLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 18)
        return label
    }()
    
    let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = Resources.Colors.separatorColor
        return separatorView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        [self.categoryLabel,
         self.periodLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = Resources.Colors.cellMainColor
    }
    
    func setup(_ transaction: Transaction) {
        self.setupCategoryImage(imageName: transaction.category.imageName, hexColor: transaction.category.hexColor)
        self.setupSumLabel(amount: transaction.payment.amount, currency: transaction.payment.currency)
        self.categoryLabel.text = transaction.category.name
        self.periodLabel.text = transaction.payment.period.rawValue.capitalized
        setViewsLayout()
    }
    
    private func setupCategoryImage(imageName: String, hexColor: String) {
        self.categoryImage.image = UIImage(systemName: imageName)
        self.categoryImage.tintColor = UIColor(hex: hexColor)
    }
    
    private func setupSumLabel(amount: Double, currency: String) {
        let plus = amount.isPositive ? "+" : ""
        self.sumLabel.text = "\(plus)\(amount.kmFormatted) \(currency)"
        
        self.sumLabel.textColor = amount.isPositive
        ? Resources.Colors.mainPositiveAmountColor
        : Resources.Colors.mainNegativeAmountColor
    }
    
   private func setViewsLayout() {
        let views = [self.categoryImage, self.stackView, self.sumLabel, self.separatorView]
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            self.categoryImage.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8),
            self.categoryImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8),
            self.categoryImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.categoryImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),

            self.stackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3),
            self.stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.categoryImage.trailingAnchor, constant: 10),

            self.sumLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.sumLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.sumLabel.leadingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: 20),

            self.separatorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.separatorView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.separatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0),
            self.separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
