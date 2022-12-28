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
    
    let kind: Kind
    let period: Period
    let amount: Double
    let currency: String
    
    enum Period {
        case today
        case week
        case month
    }
}
