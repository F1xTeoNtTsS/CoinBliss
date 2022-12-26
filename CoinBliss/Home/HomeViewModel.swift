//
//  HomeViewModel.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    let sections: [HomeModel]
    
    init() {
        self.sections = HomeMockData.shared.data
    }
}
