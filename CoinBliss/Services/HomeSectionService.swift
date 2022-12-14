//
//  HomeSectionService.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 05/01/2023.
//

import Foundation
import Combine

protocol HomeSectionService {
    func homeSectionsList() -> AnyPublisher<[HomeSection], Never>
}

extension HomeSectionService {
    func homeSectionsList() -> AnyPublisher<[HomeSection], Never> {
        Just(DataProvider.shared.data).eraseToAnyPublisher()
    }
}
