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
    var period: String
    var date: Date
    var note: String?
}

struct Category {
    let id: Int
    let name: String
    let imageName: String
    let hexColor: String
}

enum Period: String {
    case daily
    case weekly
    case mountly
    case annual
}
