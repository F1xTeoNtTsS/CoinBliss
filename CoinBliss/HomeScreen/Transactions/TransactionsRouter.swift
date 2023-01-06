//
//  TransactionsRouter.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 06/01/2023.
//

import UIKit

final class TransactionsRouter: Router {
    let navigation: UINavigationController
    let assembly: Assembly
    
    init(navigation: UINavigationController, assembly: Assembly) {
        self.navigation = navigation
        self.assembly = assembly
    }
    
    func run() {
        let viewModel = TransactionsViewModel(mode: .fullscreen)
        let transactionsController = TransactionsController(viewModel: viewModel)
        transactionsController.router = self
        transactionsController.modalPresentationStyle = .fullScreen
//        navigation.setViewControllers([transactionsController], animated: true)
        navigation.present(transactionsController, animated: true)
    }
}
