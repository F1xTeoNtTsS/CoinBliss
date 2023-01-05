//
//  MainRouter.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 05/01/2023.
//

import UIKit

protocol Router {
    func run()
}

final class MainRouter: Router {
    private let window: UIWindow?
    private let assembly: Assembly
    let navigation = UINavigationController()
    
    init(window: UIWindow?, assembly: Assembly) {
        self.assembly = assembly
        self.window = window
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func run() {
        navigation.navigationBar.isHidden = true
        let router = HomeRouter(navigation: navigation, assembly: assembly)
        router.run()
    }
}
