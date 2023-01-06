//
//  Transaction.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 26/12/2022.
//

import Foundation

struct Transaction {
    let payment: Payment
    let category: Category
}

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

struct Category: Identifiable, Codable {
    let id: Int
    let name: String
    let imageName: String
    let hexColor: String
}
