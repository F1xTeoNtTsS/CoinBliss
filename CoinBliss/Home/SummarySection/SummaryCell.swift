//
//  SummaryCell.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 28/12/2022.
//

import UIKit

class SummaryCell: UICollectionViewCell, HomeCellProtocol {
    
    static let cellId = Constants.cellId
    
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 18)
        label.sizeToFit()
        return label
    }()
    
    private lazy var describingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 14)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func setup(_ summary: Summary) {
        self.setupSumLabel(amount: summary.amount, currency: summary.currency, kind: summary.kind)
        self.setupDescribingLabel(kind: summary.kind)
        self.setupPeriodLabel(period: summary.period)
        self.setViewsLayout()
    }
    
    private func setupSumLabel(amount: Double, currency: String, kind: Summary.Kind) {
        self.sumLabel.text = "\(amount.kmFormatted) \(currency)"
        self.sumLabel.textColor = kind == .income
        ? Resources.Colors.mainPositiveColor
        : Resources.Colors.mainNegativeColor
    }
    
    private func setupDescribingLabel(kind: Summary.Kind) {
        self.describingLabel.text = kind.rawValue.capitalized
    }
    
    private func setupPeriodLabel(period: Summary.Period) {
        var text = ""
        switch period {
        case .today:
            text = "Today"
        case .week:
            text = "Week"
        case .month:
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_us")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMM")
            let nameOfMonth = dateFormatter.string(from: now)
            text = nameOfMonth
        }
        self.periodLabel.text = text
    }
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .center
        stack.distribution = .fillEqually
        [self.periodLabel,
         self.sumLabel,
         self.describingLabel].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    private func setViewsLayout() {
        let views = [self.stackView]
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private enum Constants {
        static let cellId = "SummaryCell"
    }
}
