//
//  FloatingButton.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 29/12/2022.
//

import UIKit

final class FloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConfiguration() {
        var configuration = UIButton.Configuration.bordered()
        configuration.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        configuration.cornerStyle = .capsule

        configuration.image = UIImage(systemName: "plus",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .medium))
        configuration.imagePadding = 10

        configuration.title = "Add transaction"
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: Resources.Fonts.mainFontName, size: 18)
            return outgoing
        }
        configuration.baseForegroundColor = Resources.Colors.floatingButtonForegroundColor

        self.configuration = configuration
        
        self.setDefaultShadow()
    }
}
