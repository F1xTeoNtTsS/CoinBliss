//
//  Transaction.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 21/12/2022.
//

import Foundation

struct Transaction: ListItem {
    var id: Int
    var sum: Double
    var currency: String
    var category: Int
    var period: Period
    var date: Date?
    var note: String?
    
    enum Period {
        case mountly
        case weekly
        case daily
    }
}
