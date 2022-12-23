//
//  HomeSection.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

enum HomeSection {    
    case totalAmount(TotalAmount)
    case transactions([Transaction])
    
    var items: [ListItem] {
        switch self {
        case .totalAmount(let items):
            return [items]
        case .transactions(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
}
