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
        .totalAmount(TotalAmount(sum: 60606570.55, currency: "IDR", isVisible: true))
    }()
    
    private let transactions: HomeSection = {
        .transactions([
            Transaction(name: "Caffe", sum: -10),
            Transaction(name: "Clothes", sum: -135),
            Transaction(name: "Serfing", sum: -30),
            Transaction(name: "Salary", sum: 5000)
        ])
    }()
    
    var data: [HomeSection] {
        [self.totalAmount]
    }
}
