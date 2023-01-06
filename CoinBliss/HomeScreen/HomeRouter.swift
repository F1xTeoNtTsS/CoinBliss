//
//  HomeRouter.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 05/01/2023.
//

import UIKit

final class HomeRouter: Router {
    let navigation: UINavigationController
    let assembly: Assembly
    
    init(navigation: UINavigationController, assembly: Assembly) {
        self.navigation = navigation
        self.assembly = assembly
    }
    
    func run() {
        let viewModel = HomeViewModel()
        let listController = HomeViewController(viewModel: viewModel)
        listController.router = self
        navigation.setViewControllers([listController], animated: true)
    }
    
    func openTransationsVC() {
        let transactionsRouter = TransactionsRouter(navigation: navigation, assembly: assembly)
        transactionsRouter.run()
    }
}
