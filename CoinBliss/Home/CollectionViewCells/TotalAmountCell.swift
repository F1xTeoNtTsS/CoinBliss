//
//  TotalAmountCell.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import UIKit

class TotalAmountCell: UICollectionViewCell {
    static let cellId = "TotalAmountCell"
    
    private lazy var hideButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 3
        
        var configuration = UIButton.Configuration.plain()
        var atr = AttributeContainer()
        atr.font = UIFont(name: "Heebo-Regular_Medium", size: 30)
        atr.foregroundColor = .white
        configuration.attributedTitle = AttributedString("O", attributes: atr)
        configuration.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        button.configuration = configuration
        
        return button
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Heebo-Regular_Medium", size: 30)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var currencyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 3
        
        var configuration = UIButton.Configuration.plain()
        var atr = AttributeContainer()
        atr.font = UIFont(name: "Heebo-Regular_Medium", size: 30)
        atr.foregroundColor = .white
        configuration.attributedTitle = AttributedString("USD", attributes: atr)
        configuration.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        button.configuration = configuration
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 3
        
        self.layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(_ totalAmount: TotalAmount) {
        let formatter = makeFormatter()
        let number = NSNumber(value: totalAmount.total)
        
        self.amountLabel.text = formatter.string(from: number)
    }
    
    private func makeFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = " "
        return formatter
    }
    
    private func layoutViews() {
        let views = [self.hideButton, self.amountLabel, self.currencyButton]
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        NSLayoutConstraint.activate([
            self.amountLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5),
            self.amountLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            self.amountLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.amountLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
}
