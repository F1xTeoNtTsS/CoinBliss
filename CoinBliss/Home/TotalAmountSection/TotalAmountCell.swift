//
//  TotalAmountCell.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import UIKit

final class TotalAmountCell: UICollectionViewCell, HomeCellProtocol {
    static let cellId = Constants.cellId
    var cellModel: TotalAmount? {
        didSet {
            guard let cellModel = cellModel else { return }
            self.setup(cellModel)
        }
    }
    
    var eyeButtonTapHandler: (() -> Void)?
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.buttonsCornerRadius
        
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .white
        configuration.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        button.configuration = configuration
        button.addTarget(self, action: #selector(abc), for: .touchUpInside)
        
        return button
    }()
    
    @objc func abc(button: UIButton) {
        guard let handler = self.eyeButtonTapHandler else { return }
        handler()
    }
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: Constants.amountLabelFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var describingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: Constants.describinglabelFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.text = "NET BALANCE"
        label.textColor = Resources.Colors.headerTextColor
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var currencyButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.buttonsCornerRadius
        
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(_ totalAmount: TotalAmount) {
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
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 0
            formatter.currencySymbol = ""
            formatter.currencyDecimalSeparator = ","
            formatter.currencyGroupingSeparator = " "
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
    
    private func setViewsLayout() {
        let views = [self.eyeButton, self.currencyButton, self.amountLabel, self.describingLabel]
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            self.eyeButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.4),
            self.eyeButton.widthAnchor.constraint(equalTo: self.eyeButton.heightAnchor),
            self.eyeButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.eyeButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            
            self.currencyButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.4),
            self.currencyButton.widthAnchor.constraint(lessThanOrEqualToConstant:
                                                        self.currencyButton.intrinsicContentSize.width),
            self.currencyButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.currencyButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            self.amountLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.amountLabel.leadingAnchor.constraint(equalTo: self.eyeButton.trailingAnchor, constant: 20),
            self.amountLabel.trailingAnchor.constraint(equalTo: self.currencyButton.leadingAnchor, constant: -20),
            
            self.describingLabel.widthAnchor.constraint(lessThanOrEqualTo: self.contentView.widthAnchor,
                                                     multiplier: Constants.viewSizeMultiplier),
            self.describingLabel.topAnchor.constraint(equalTo: self.amountLabel.bottomAnchor),
            self.describingLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    private enum Constants {
        static let cellId = "TotalAmountCell"
        static let textWithStars = "**********"
        static let viewSizeMultiplier: CGFloat = 0.7
        static let buttonsCornerRadius: CGFloat = 10
        static let amountLabelFontSize: CGFloat = 30
        static let describinglabelFontSize: CGFloat = 12
    }
}
