//
//  TotalAmountCell.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import UIKit

class TotalAmountCell: UICollectionViewCell {
    static let cellId = Constants.cellId
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.buttonsCornerRadius
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .white
        configuration.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        configuration.background.backgroundColor = Resources.Colors.mainColor
        button.configuration = configuration
        
        return button
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: Constants.amountLabelFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var describeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: Constants.describelabelFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.text = "NET BALANCE"
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var currencyButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.buttonsCornerRadius
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)
        configuration.baseForegroundColor = .white
        configuration.background.backgroundColor = Resources.Colors.mainColor
        button.configuration = configuration
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ totalAmount: TotalAmount) {
        self.setupEyeButton(isVisible: totalAmount.isVisible)
        self.setupAmountTitle(amount: totalAmount.balance, isVisible: totalAmount.isVisible)
        self.setupCurrencyButton(currency: totalAmount.currency)
        self.setViewsLayout()
    }
    
    private func setupEyeButton(isVisible: Bool) {
        let image = UIImage(systemName: isVisible ? Resources.Icons.eye : Resources.Icons.eyeSlash)
        self.eyeButton.setImage(image, for: .normal)
    }
    
    private func setupAmountTitle(amount: Double, isVisible: Bool) {
        var text: String? = Constants.textWithStars
        if isVisible {
            let formatter = makeFormatter()
            let number = NSNumber(value: amount)
            text = formatter.string(from: number)
        }
        self.amountLabel.text = text
    }
    
    private func setupCurrencyButton(currency: String) {
        var atr = AttributeContainer()
        atr.font = UIFont(name: Resources.Fonts.mainFontName, size: 24)
        let atrString = NSAttributedString(AttributedString(currency, attributes: atr))
        self.currencyButton.setAttributedTitle(atrString, for: .normal)
    }
    
    private func makeFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = " "
        return formatter
    }
    
    private func setViewsLayout() {
        let views = [self.eyeButton, self.currencyButton, self.amountLabel, self.describeLabel]
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            self.eyeButton.heightAnchor.constraint(greaterThanOrEqualTo: self.contentView.heightAnchor, multiplier: 0.4),
            self.eyeButton.widthAnchor.constraint(equalTo: self.eyeButton.heightAnchor),
            self.eyeButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.eyeButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            
            self.currencyButton.heightAnchor.constraint(greaterThanOrEqualTo: self.contentView.heightAnchor, multiplier: 0.4),
            self.currencyButton.widthAnchor.constraint(lessThanOrEqualToConstant: self.currencyButton.intrinsicContentSize.width),
            self.currencyButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.currencyButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
//            self.amountLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor,
//                                                    multiplier: Constants.viewSizeMultiplier),
            
//            self.amountLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.amountLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.amountLabel.leadingAnchor.constraint(equalTo: self.eyeButton.trailingAnchor, constant: 20),
            self.amountLabel.trailingAnchor.constraint(equalTo: self.currencyButton.leadingAnchor, constant: -20),
//
            self.describeLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor,
                                                     multiplier: Constants.viewSizeMultiplier),
            self.describeLabel.topAnchor.constraint(equalTo: self.amountLabel.bottomAnchor),
            self.describeLabel.centerXAnchor.constraint(equalTo: self.amountLabel.centerXAnchor),
//
//
//

        ])
    }
    
    private enum Constants {
        static let cellId = "TotalAmountCell"
        static let textWithStars = "**********"
        static let viewSizeMultiplier: CGFloat = 0.7
        static let buttonsCornerRadius: CGFloat = 10
        static let amountLabelFontSize: CGFloat = 30
        static let describelabelFontSize: CGFloat = 12
    }
}
