//
//  HomeModel.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

enum HomeSection {    
    case totalAmountSection(TotalAmount)
    case summarySection([Summary])
    case transactionsSection(transactionsCount: Int)
    
    var title: String {
        switch self {
        case .totalAmountSection:
            return ""
        case .summarySection:
            return "SUMMARY"
        case .transactionsSection:
            return "RECENT TRANSACTIONS"
        }
    }
}
