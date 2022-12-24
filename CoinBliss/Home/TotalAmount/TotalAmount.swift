//
//  TotalAmount.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 21/12/2022.
//

protocol SectionItem { }

struct TotalAmount: SectionItem {
    var balance: Double
    var currency: String
    var isVisible: Bool
}
