//
//  MockData.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import Foundation

final class MockData {
    static let shared = MockData()
    
    private init() {}
    
    private let totalAmount: HomeSection = {
        .totalAmount(TotalAmount(balance: 156888570.55, currency: "IDR", isVisible: true))
    }()
    
    private let transactions: HomeSection = {
        .transactions([
            Transaction(id: 1, sum: 15000.500, currency: "IDR", category: 1, period: .daily, date: MockData.getRandomDate()),
            Transaction(id: 2, sum: -100, currency: "USD", category: 2, period: .mountly),
            Transaction(id: 3, sum: 5000.70, currency: "RUB", category: 66, period: .weekly),
            Transaction(id: 4, sum: 90000, currency: "IDR", category: 4, period: .daily, date: MockData.getRandomDate(), note: "tips"),
            Transaction(id: 5, sum: 500000, currency: "IDR", category: 2, period: .weekly)
        ])
    }()
    
    static func getRandomDate() -> Date? {
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        guard
            let days = calendar.range(of: .day, in: .month, for: date),
            let randomDay = days.randomElement()
        else {
                return nil
        }
        dateComponents.setValue(randomDay, for: .day)
        return calendar.date(from: dateComponents)
    }
    
    var data: [HomeSection] {
        [self.totalAmount,
         self.transactions]
    }
}
