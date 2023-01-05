//
//  BaseViewController.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 05/01/2023.
//

import UIKit

class BaseViewController<M>: UIViewController {
    
    private(set) var viewModel: M
    
    init(viewModel: M) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        view.backgroundColor = .clear
    }
}
