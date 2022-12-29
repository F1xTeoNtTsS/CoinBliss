//
//  HomeModel.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

enum HomeSection {    
    case totalAmountSection(TotalAmount)
    case summarySection([Summary])
    case transactionsSection([Transaction])
    
    var title: String {
        switch self {
        case .totalAmountSection:
            return ""
        case .summarySection:
            return "Summary"
        case .transactionsSection:
            return "Recent transactions"
        }
    }
}
