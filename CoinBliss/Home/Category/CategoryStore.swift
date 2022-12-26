//
//  CategoryStore.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 22/12/2022.
//

import SwiftUI

final class CategoryStore: ObservableObject {
    
    static let shared = CategoryStore()
    
    let categories: [Int: Category] = [
        0: Category(id: 0, name: "House Rent", imageName: "house.circle.fill", hexColor: "34568B"),
        1: Category(id: 1, name: "Medicine", imageName: "pills.circle.fill", hexColor: "FF6F61"),
        2: Category(id: 2, name: "Transport", imageName: "car.circle.fill", hexColor: "6B5B95"),
        3: Category(id: 3, name: "Pets", imageName: "pawprint.circle.fill", hexColor: "88B04B"),
        4: Category(id: 4, name: "Gift", imageName: "gift.circle.fill", hexColor: "F7CAC9"),
        5: Category(id: 5, name: "Beauty", imageName: "scissors.circle.fill", hexColor: "92A8D1"),
        6: Category(id: 6, name: "Shoping", imageName: "cart.circle.fill", hexColor: "955251"),
        7: Category(id: 7, name: "Food", imageName: "fork.knife.circle.fill", hexColor: "B565A7"),
        8: Category(id: 8, name: "Intertainment", imageName: "theatermasks.circle.fill", hexColor: "009B77"),
        9: Category(id: 9, name: "Travel", imageName: "airplane.circle.fill", hexColor: "55B4B0"),
    ]
    
    private init() {}
    
    func categoryById(_ id: Int) -> Category {
        return CategoryStore.shared.categories[id] ?? Category(id: 0, name: "", imageName: "", hexColor: "")
    }
}
