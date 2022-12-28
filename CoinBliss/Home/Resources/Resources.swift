//
//  Resources.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 21/12/2022.
//

import UIKit.UIColor

enum Resources {
    enum Fonts {
        static let mainFontName = "Heebo-Regular_Medium"
    }
    
    enum Colors {
        static let mainPositiveColor = UIColor(cgColor: CGColor(srgbRed: (65/255.0),
                                                                green: (200/255.0),
                                                                blue: (163/255.0),
                                                                alpha: 1))
        static let mainNegativeColor = UIColor(cgColor: CGColor(srgbRed: (220/255.0),
                                                                green: (50/255.0),
                                                                blue: (30/255.0),
                                                                alpha: 1))
    }
    
    enum Icons {
        static let eye = "eye"
        static let eyeSlash = "eye.slash"
    }
}
