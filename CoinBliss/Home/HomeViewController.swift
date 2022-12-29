//
//  HomeViewController.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 12.12.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    private let gradientLayer = CAGradientLayer()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundGradient()
        self.setupCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.gradientLayer.frame = self.view.bounds
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeCollectionViewFlowLayout())
        
        collectionView.register(TotalAmountCell.self,
                                forCellWithReuseIdentifier: TotalAmountCell.cellId)
        collectionView.register(SummaryCell.self,
                                forCellWithReuseIdentifier: SummaryCell.cellId)
        collectionView.register(MultiplyTransactionCell.self,
                                forCellWithReuseIdentifier: MultiplyTransactionCell.cellId)
        collectionView.register(CollectionViewHeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "CollectionViewHeaderReusableView")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setCollectionViewLayout()
    }
    
    private func setupBackgroundGradient() {
        self.view.backgroundColor = .white
        self.gradientLayer.colors = [Resources.Colors.mainPositiveColor.cgColor,
                                     UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.viewModel.sections[section] {
        case .summarySection(let summaries):
            return summaries.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.viewModel.sections[indexPath.section] {
        case .totalAmountSection(let totalAmount):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TotalAmountCell.cellId,
                                                                for: indexPath) as? TotalAmountCell else {
                return  UICollectionViewCell()
            }
            cell.setupCell(totalAmount)
            return cell
        case .summarySection(let summary):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCell.cellId,
                                                                for: indexPath) as? SummaryCell else {
                return  UICollectionViewCell()
            }
            cell.setup(summary[indexPath.row])
            return cell
        case .transactionsSection(let transactions):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultiplyTransactionCell.cellId,
                                                                for: indexPath) as? MultiplyTransactionCell else {
                return UICollectionViewCell()
            }
            cell.setup(transactions)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind,
                                                  withReuseIdentifier: "CollectionViewHeaderReusableView",
                                                  for: indexPath) as? CollectionViewHeaderReusableView
            header?.setup(viewModel.sections[indexPath.section].title)
            return header ?? CollectionViewHeaderReusableView()
        default:
            return UICollectionReusableView()
        }
    }
}

extension HomeViewController {
    private func setCollectionViewLayout() {
        collectionView.backgroundColor = .clear
        self.view.addSubview(self.collectionView)
        self.collectionView.frame = self.view.frame
    }
    
    private func makeCollectionViewFlowLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.viewModel.sections[sectionIndex]
            switch section {
            case .totalAmountSection:
                let section = self.layoutTotalAmountSection()
                return section
            case .summarySection:
                let section = self.layoutSummarySection()
                return section
            case .transactionsSection(let transactions):
                let section = self.layoutTransactionsSection(transactionsCount: transactions.count)
                return section
            }
        }
    }
    
    private func layoutTotalAmountSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .absolute(100)),
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: -10, leading: 20, bottom: 0, trailing: 20)
        return section
    }
    
    private func layoutSummarySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                .init(widthDimension: .absolute((self.collectionView.frame.width - 60) / 2),
                      heightDimension: .absolute(90)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.interGroupSpacing = 20
        section.contentInsets = .init(top: 0, leading: 20, bottom: 10, trailing: 20)
        section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
        return section
    }
    
    private func layoutTransactionsSection(transactionsCount: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .absolute(CGFloat(70 * transactionsCount - 1))), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 10, trailing: 20)
        section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .topLeading)
    }
}
