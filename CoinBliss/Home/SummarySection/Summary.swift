//
//  Summary.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 28/12/2022.
//

import Foundation

struct Summary {
    enum Kind: String {
        case income
        case expence
    }
    
    var kind: Kind
    var period: Period
    var amount: Double
    var currency: String
    
    enum Period {
        case today
        case week
        case month
    }
}
