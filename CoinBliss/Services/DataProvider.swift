//
//  DataProvider.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import Foundation

final class DataProvider {
    static let shared = DataProvider()
    
    var transactions: [Transaction] = []
    var categories: [Int: Category] = [:]
    var totalAmount = TotalAmount(balance: 999098570, currency: "IDR", isVisible: true)
    
    private let coreDataManager = CoreDataManager()
    
    private init() {
        self.fetchTransactions()
    }
    
    func addRandomTransaction() {
        let payment = Payment(id: 100_000_007,
                              amount: 100500,
                              currency: "AUD",
                              categoryId: 7,
                              period: Period.mountly.rawValue,
                              date: Date())
        self.coreDataManager.save(payment: payment)
        self.fetchTransactions()
    }
    
    private func fetchTransactions() {
        var payment = coreDataManager.fetchPayments()
        payment.sort(by: { $0.id > $1.id })
        let categories = coreDataManager.fetchCategories()
        self.categories = categories
        self.transactions = payment.map { Transaction(payment: $0, category: categories[$0.categoryId]!)}
    }
}

extension DataProvider {
    var data: [HomeSection] {
        return [self.totalAmountSection(),
                self.summarySection(),
                self.recentTransactionsSection()]
    }
    
    private func totalAmountSection() -> HomeSection {
        HomeSection.totalAmountSection(self.totalAmount)
    }
    
    private func summarySection() -> HomeSection {
        let summaries: [Summary] = [
            Summary(kind: .income, period: .month, amount: 555000000, currency: "IDR"),
            Summary(kind: .expence, period: .today, amount: -300000, currency: "IDR")
        ]
        return HomeSection.summarySection(summaries)
    }
    
    private func recentTransactionsSection() -> HomeSection {
        let count = self.transactions.count >= 5 ? 5 : self.transactions.count
        
        return HomeSection.transactionsSection(transactionsCount: count)
    }
}
