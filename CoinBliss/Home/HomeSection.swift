//
//  HomeSection.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import Foundation

enum HomeSection {
    case totalAmount(TotalAmount)
    case transactions([Transaction])
    case somethingElse(SomethingElse)
    
    var title: String {
        switch self {
        case .totalAmount:
            return "Total amount"
        case .transactions:
            return "Transactions"
        case .somethingElse:
            return "Something else"
        }
    }
}

struct TotalAmount {
    var sum: Double
    var currency: String
    var isVisible: Bool
}

struct Transaction {
    var name: String
    var sum: Int
}

struct SomethingElse {
}
