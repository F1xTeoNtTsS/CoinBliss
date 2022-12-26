//
//  Payment.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 21/12/2022.
//

import Foundation

struct Payment {
    var id: Int
    var amount: Double
    var currency: String
    var categoryId: Int
    var period: Period
    var date: Date
    var note: String?
    
    enum Period: String {
        case mountly
        case weekly
        case daily
    }
}
