//
//  HeaderReusableView.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 29/12/2022.
//

import UIKit

final class HeaderReusableView: UICollectionReusableView {
    static let viewId = "HeaderReusableView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Resources.Colors.headerTextColor
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ title: String) {
        self.titleLabel.text = title
        self.setViewsLayout()
    }
    
    private func setViewsLayout() {
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
