//
//  CollectionViewHeaderReusableView.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 29/12/2022.
//

import UIKit

final class CollectionViewHeaderReusableView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.font = UIFont(name: Resources.Fonts.mainFontName, size: 18)
        return label
    }()
    
    func setup(_ title: String) {
        titleLabel.text = title
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
