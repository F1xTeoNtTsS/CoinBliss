//
//  Assembly.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 05/01/2023.
//

import UIKit

final class Assembly {
    private let window: UIWindow?
    init(window: UIWindow?) {
        self.window = window
    }
    
    lazy var mainRouter: MainRouter = MainRouter(
        window: window,
        assembly: self
    )
}
