//
//  PaymentStore.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 25/12/2022.
//

import Foundation

final class PaymentStore {
    static let shared = PaymentStore()
    
    let payments = [
        Payment(id: 0, amount: 9999815000.500, currency: "IDR",
                categoryId: 0, period: .daily, date: PaymentStore.getRandomDate()),
        Payment(id: 1, amount: -100, currency: "USD",
                categoryId: 1, period: .mountly, date: PaymentStore.getRandomDate()),
        Payment(id: 2, amount: 55005000.70, currency: "RUB",
                categoryId: 3, period: .weekly, date: PaymentStore.getRandomDate()),
        Payment(id: 3, amount: -90000, currency: "IDR",
                categoryId: 5, period: .daily, date: PaymentStore.getRandomDate(), note: "tips"),
        Payment(id: 4, amount: -500000, currency: "IDR",
                categoryId: 7, period: .weekly, date: PaymentStore.getRandomDate()),
        Payment(id: 5, amount: 100000, currency: "IDR",
                categoryId: 6, period: .daily, date: PaymentStore.getRandomDate()),
        Payment(id: 6, amount: 15000.500, currency: "IDR",
                categoryId: 2, period: .daily, date: PaymentStore.getRandomDate()),
        Payment(id: 7, amount: -100, currency: "USD",
                categoryId: 7, period: .mountly, date: PaymentStore.getRandomDate()),
        Payment(id: 8, amount: 5000.70, currency: "RUB",
                categoryId: 1, period: .weekly, date: PaymentStore.getRandomDate()),
        Payment(id: 9, amount: 90000, currency: "IDR",
                categoryId: 4, period: .daily, date: PaymentStore.getRandomDate(), note: "tips"),
        Payment(id: 10, amount: 95000, currency: "IDR",
                categoryId: 8, period: .weekly, date: PaymentStore.getRandomDate()),
        Payment(id: 11, amount: 100000, currency: "IDR",
                categoryId: 9, period: .daily, date: PaymentStore.getRandomDate())
    ]
    
    private init() { }
    
    static func getRandomDate() -> Date {
        let date = Date()
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let days = calendar.range(of: .day, in: .month, for: date)
        let randomDay = days?.randomElement()
        dateComponents.setValue(randomDay, for: .day)
        return calendar.date(from: dateComponents) ?? date
    }
    
    func lastFivePayments() -> [Payment] {
        let count = PaymentStore.shared.payments.count
        let prefix = count >= 5 ? 5 : count
        
        return Array(PaymentStore.shared.payments
            .sorted(by: {$0.date < $1.date})
            .prefix(upTo: prefix))
    }
}
