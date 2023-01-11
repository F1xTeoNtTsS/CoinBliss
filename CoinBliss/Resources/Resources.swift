//
//  Resources.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 21/12/2022.
//

import UIKit.UIColor

public enum Resources {
    public enum Fonts {
        static let mainFontName = "Heebo-Regular_Medium"
    }
    
    public enum Colors {
        public static let mainPositiveColor = UIColor(hex: "7654fa")
        public static let mainNegativeColor = UIColor(hex: "be375f")
        
        public static let mainPositiveAmountColor = UIColor(hex: "41c8a4")
        public static let mainNegativeAmountColor = UIColor(hex: "c84141")
        
        public static var cellMainColor: UIColor = {
            Colors.colorByTheme(light: .white, dark: UIColor(hex: "292f33"))
        }()
        
        public static var titleColor: UIColor = {
            Colors.colorByTheme(light: .darkGray, dark: .lightText)
        }()
        
        public static var floatingButtonForegroundColor: UIColor = {
            Colors.colorByTheme(light: .white, dark: .systemGray6)
        }()
        
        public static var headerTextColor: UIColor = {
            Colors.colorByTheme(light: .white, dark: .lightText)
        }()
        
        public static var separatorColor: UIColor = {
            Colors.colorByTheme(light: UIColor(white: 0.1, alpha: 0.2), dark: UIColor(white: 0.5, alpha: 0.5))
        }()
        
        private static func colorByTheme(light: UIColor, dark: UIColor) -> UIColor {
            UIColor { (traitCollection: UITraitCollection) -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return dark
                default:
                    return light
                }
            }
        }
    }
    
    public enum Icons {
        static let eye = "eye"
        static let eyeSlash = "eye.slash"
    }
}
