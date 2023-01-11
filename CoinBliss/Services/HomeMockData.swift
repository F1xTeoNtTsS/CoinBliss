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
    
    var totalAmount = TotalAmount(balance: 999098570, currency: "IDR", isVisible: true)
    
    func makeSectionForTotalAmount(_ totalAmount: TotalAmount) -> HomeSection {
        HomeSection.totalAmountSection(totalAmount)
    }
    
    private var recentTransactions: HomeSection = {
        let lastFivePayments = PaymentStore.shared.lastFivePayments()
        let transactions = lastFivePayments.map {
            Transaction(payment: $0, category: CategoryStore.shared.categoryById($0.categoryId))}
        return HomeSection.transactionsSection(transactions)
    }()
    
    private let summary: HomeSection = {
        let summaries: [Summary] = [
            Summary(kind: .income, period: .month, amount: 555000000, currency: "IDR"),
            Summary(kind: .expence, period: .today, amount: -300000, currency: "IDR")
        ]
        return HomeSection.summarySection(summaries)
    }()
    
    static func getRandomCategory() -> Category {
        Category(id: 0, name: "House Rent", imageName: "house.circle", hexColor: "")
    }
    
    var data: [HomeSection] {
        [self.makeSectionForTotalAmount(self.totalAmount),
         self.summary,
         self.recentTransactions]
    }
    
    var allTransactions: [Transaction] {
        let transactions = PaymentStore.shared.payments.map {
            Transaction(payment: $0, category: CategoryStore.shared.categoryById($0.categoryId))}
        return transactions
    }
}
