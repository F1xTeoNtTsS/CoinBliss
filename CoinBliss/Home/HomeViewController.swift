//
//  HomeViewController.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 12.12.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    private var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.makeCollectionViewLayout())
        self.view.addSubview(self.collectionView)
        
        collectionView.register(TotalAmountCell.self, forCellWithReuseIdentifier: TotalAmountCell.cellId)
        collectionView.register(TransactionsCell.self, forCellWithReuseIdentifier: TransactionsCell.cellId)
        collectionView.register(SomethingElseCell.self, forCellWithReuseIdentifier: SomethingElseCell.cellId)
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderReusableView.viewId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let section = self.viewModel.sections[sectionIndex]
            switch section {
            case .totalAmount(_):
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 5, leading: 10, bottom: 10, trailing: 10)
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
                return section
            case .transactions(_):
                return nil
            case .somethingElse(_):
                return nil
            }
        }
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(50)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.viewModel.sections[indexPath.section] {
        case .totalAmount(let totalAmount):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalAmountCell.cellId,
                                                          for: indexPath) as! TotalAmountCell
            cell.setup(totalAmount)
            return cell
        case .transactions(let transactions):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionsCell.cellId,
                                                          for: indexPath) as! TransactionsCell
            cell.setup(transactions)
            return cell
        case .somethingElse(let somethingElse):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SomethingElseCell.cellId,
                                                          for: indexPath) as! SomethingElseCell
            cell.setup(somethingElse)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: HeaderReusableView.viewId,
                                                                         for: indexPath) as! HeaderReusableView
            header.setup(self.viewModel.sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
