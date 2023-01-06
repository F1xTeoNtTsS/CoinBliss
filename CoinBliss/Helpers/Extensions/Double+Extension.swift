//
//  Double+Extension.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 27/12/2022.
//

import Foundation

extension Double {
    var kmFormatted: String {
        if self > 99999999 && self <= 999999999 {
            return String(format: "%.1fM",
                          locale: .current,
                          self/1000000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 999999999 && self <= 999999999999 {
            return String(format: "%.1fB",
                          locale: .current,
                          self/1000000000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 999999999999 && self <= 999999999999999 {
            return String(format: "%.1fT",
                          locale: .current,
                          self/1000000000000).replacingOccurrences(of: ".0", with: "")
        }
        
        if self > 999999999999999 {
            return "🤡"
        }

        return String(format: "%.0f", locale: .current, self).replacingOccurrences(of: ",", with: " ")
    }
    
    var isPositive: Bool {
        return self > 0
    }
}
