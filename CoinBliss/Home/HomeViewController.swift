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
        collectionView.register(MultiplyTransactionCell.self,
                                forCellWithReuseIdentifier: MultiplyTransactionCell.cellId)
        
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
        case .transactionsSection(let transactionsPreview):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultiplyTransactionCell.cellId,
                                                                for: indexPath) as? MultiplyTransactionCell else {
                return UICollectionViewCell()
            }
            cell.setup(transactionsPreview)
            return cell
        }
    }
}

extension HomeViewController {
    private func makeCollectionViewFlowLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.viewModel.sections[sectionIndex]
            switch section {
            case .totalAmountSection:
                let section = self.layoutTotalAmountSection()
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
        section.contentInsets = .init(top: 0, leading: 20, bottom: 10, trailing: 20)
        return section
    }
    
    private func layoutTransactionsSection(transactionsCount: Int) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize:
                .init(widthDimension: .fractionalWidth(1),
                      heightDimension: .absolute(CGFloat(70 * transactionsCount - 1))), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 20)
        return section
    }
    
    private func setCollectionViewLayout() {
        collectionView.backgroundColor = .clear
        self.view.addSubview(self.collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
    }
}
