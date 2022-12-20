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
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 3
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "eye.slash")
        configuration.baseForegroundColor = .white
        configuration.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        configuration.background.backgroundColor = UIColor(cgColor: CGColor(srgbRed: (65/255.0), green: (200/255.0), blue: (163/255.0), alpha: 1.0))
        button.configuration = configuration
        
        return button
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Heebo-Regular_Medium", size: 30)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        
//        label.frame.size = label.intrinsicContentSize
        return label
    }()
    
    private lazy var currencyButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 3
        
        var configuration = UIButton.Configuration.plain()
        var atr = AttributeContainer()
        atr.font = UIFont(name: "Heebo-Regular_Medium", size: 30)
        atr.foregroundColor = .white
        configuration.attributedTitle = AttributedString("USD", attributes: atr)
        configuration.contentInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 10)
        configuration.background.backgroundColor = UIColor(cgColor: CGColor(srgbRed: (65/255.0), green: (200/255.0), blue: (163/255.0), alpha: 1.0))
        button.configuration = configuration
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
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
            self.amountLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor, multiplier: 0.5),
            self.amountLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            self.amountLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.amountLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
//            self.hideButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2),
//            self.hideButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            self.hideButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.hideButton.trailingAnchor.constraint(equalTo: self.amountLabel.leadingAnchor, constant: -10),
//            self.hideButton.leadingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
//            self.hideButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2),
//            self.hideButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            self.currencyButton.widthAnchor.constraint(greaterThanOrEqualToConstant: self.currencyButton.intrinsicContentSize.width),
            self.currencyButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.currencyButton.leadingAnchor.constraint(equalTo: self.amountLabel.trailingAnchor, constant: 10),
            self.currencyButton.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor,
                                                          constant: -20)
        ])
    }
}
