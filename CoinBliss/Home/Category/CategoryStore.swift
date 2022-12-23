//
//  CategoryStore.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 22/12/2022.
//

import SwiftUI

final class CategoryStore: ObservableObject {
    
    static let shared = CategoryStore()
    
    private init() {}
    
    func getCategoryForId(_ id: Int) -> Category {
        return Category(id: 1, name: "", icon: "", color: "")
    }
}
