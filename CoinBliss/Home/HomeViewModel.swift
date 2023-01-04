//
//  HomeViewModel.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var sections: [HomeSection] = []
    
    init() {
        self.sections = HomeMockData.shared.data
    }
    
    func fetchData() {
        self.sections = HomeMockData.shared.data2
    }
    
    func eyeButtonTapped() {
        // coredata -> totalAmount
        // totalAmount.isVisible.toggle()
        // save totalAmount
        //
        // make new section using new TotalAmount instead current TotalAmount section
        HomeMockData.shared.totalAmount.isVisible.toggle()
        self.sections[0] = HomeMockData.shared.makeSectionForTotalAmount(HomeMockData.shared.totalAmount)
    }
      
      private var cancellables = Set<AnyCancellable>()
}
