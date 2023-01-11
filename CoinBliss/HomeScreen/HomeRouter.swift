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
    
    func openAppropriateVC(indexPath: IndexPath) {
        var router: Router?
        switch indexPath {
        case CellIndexPath.totalAmount:
            print("totalAmount")
        case CellIndexPath.income:
            print("income")
        case CellIndexPath.expence:
            print("expence")
        case CellIndexPath.transactions:
            router = TransactionsRouter(navigation: self.navigation, assembly: self.assembly)
        default:
            break
        }
        router?.run()
    }
    
    private enum CellIndexPath {
        static let totalAmount: IndexPath = [0, 0]
        static let income: IndexPath = [1, 0]
        static let expence: IndexPath = [1, 1]
        static let transactions: IndexPath = [2, 0]
    }
}
