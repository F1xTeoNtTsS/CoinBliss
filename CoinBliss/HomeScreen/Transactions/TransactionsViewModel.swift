//
//  TransactionsViewModel.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 06/01/2023.
//

import Foundation
import Combine

enum Mode {
    case fullscreen, small
}

final class TransactionsViewModel {
    var mode: Mode
    @Published var transactions = [Transaction]()
    
    init(mode: Mode) {
        self.mode = mode
        self.transactions = DataProvider.shared.transactions
    }
    
    func updateTransactions() {
        self.transactions = DataProvider.shared.transactions
    }
}
