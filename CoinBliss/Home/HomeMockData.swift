//
//  HomeMockData.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import Foundation

final class HomeMockData {
    static let shared = HomeMockData()
    
    private init() {}
    
    private let totalAmount: HomeModel = {
        .totalAmountSection(TotalAmount(balance: 999098570, currency: "IDR", isVisible: true))
    }()
    
    private let transactions: HomeModel = {
        let lastFivePayments = PaymentStore.shared.lastFivePayments()
        let transactions = lastFivePayments.map {
            Transaction(payment: $0, category: CategoryStore.shared.categoryById($0.categoryId))}
        return HomeModel.transactionsSection(transactions)
    }()
    
    private let summary: HomeModel = {
        let summaries: [Summary] = [
            Summary(kind: .income, period: .month, amount: 555000000, currency: "IDR"),
            Summary(kind: .expence, period: .today, amount: -300000, currency: "IDR")
        ]
        return HomeModel.summarySection(summaries)
    }()
    
    static func getRandomDate() -> Date {
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let days = calendar.range(of: .day, in: .month, for: date)
        let randomDay = days?.randomElement()
        dateComponents.setValue(randomDay, for: .day)
        return calendar.date(from: dateComponents) ?? date
    }
    
    static func getRandomCategory() -> Category {
        return Category(id: 0, name: "House Rent", imageName: "house.circle", hexColor: "")
    }
    
    var data: [HomeModel] {
        [self.totalAmount,
         self.summary,
         self.transactions]
    }
}
