//
//  HomeSection.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

enum HomeSection {    
    case totalAmount(TotalAmount)
    case transactions([Transaction])
    
    var items: [SectionItem] {
        switch self {
        case .totalAmount(let item):
            return [item]
        case .transactions(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
}
