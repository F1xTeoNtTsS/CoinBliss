import Foundation
import Combine

final class HomeViewModel: HomeSectionService {
    
    @Published var sections = [HomeSection]()
    
    init() {
        self.loadSections()
    }
    
    func eyeButtonTapped() {
        HomeMockData.shared.totalAmount.isVisible.toggle()
        self.loadSections()
    }
    
    func loadSections() {
        let receiveSectionsHandler: ([HomeSection]) -> Void = { [weak self] sections in
            self?.sections = sections
        }
        
        homeSectionsList()
            .flatMap { value -> AnyPublisher<[HomeSection], Never> in
                Just(value).eraseToAnyPublisher()
            }
            .sink(receiveValue: receiveSectionsHandler)
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
}
