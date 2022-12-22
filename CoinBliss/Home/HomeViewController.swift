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
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.gradientLayer.frame = self.view.bounds
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeCollectionViewFlowLayout())
        
        collectionView.register(TotalAmountCell.self, forCellWithReuseIdentifier: TotalAmountCell.cellId)
        collectionView.register(TransactionsCell.self, forCellWithReuseIdentifier: TransactionsCell.cellId)
        collectionView.register(SomethingElseCell.self, forCellWithReuseIdentifier: SomethingElseCell.cellId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        layoutCollectionView()
    }
    
    private func setupBackgroundGradient() {
        self.view.backgroundColor = .white
        self.gradientLayer.colors = [Resources.Colors.mainColor.cgColor,
                                     UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
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
            cell.setupCell(totalAmount)
            return cell
        case .transactions(let transactions):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionsCell.cellId,
                                                          for: indexPath) as! TransactionsCell
            cell.setup(transactions)
            return cell
        }
    }
}

extension HomeViewController {
    private func makeCollectionViewFlowLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let section = self.viewModel.sections[sectionIndex]
            switch section {
            case .totalAmount(_):
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0, leading: 10, bottom: 10, trailing: 10)
                return section
            case .transactions(_):
                return nil
            }
        }
    }
    
    private func layoutCollectionView() {
        collectionView.backgroundColor = .clear
        self.view.addSubview(self.collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
    }
}
