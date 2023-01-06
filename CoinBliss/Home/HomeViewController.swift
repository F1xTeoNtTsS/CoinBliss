//
//  HomeViewController.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 12.12.2022.
//

import UIKit
import Combine
import CombineCocoa

final class HomeViewController: BaseViewController<HomeViewModel> {
    var router: HomeRouter?
    
    private let gradientLayer = CAGradientLayer()
    private let floatingButton = FloatingButton()
    
    private var cancellables = Set<AnyCancellable>()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundGradient()
        self.setupCollectionView()
        self.setupFloatingButton()
        
        self.setupBinders()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setupBackgroundGradient()
    }
    
    private func setupBackgroundGradient() {
        self.gradientLayer.frame = self.view.bounds
        self.view.backgroundColor = .white
        self.gradientLayer.colors = [Resources.Colors.mainPositiveColor.cgColor,
                                     UIColor.systemGray6.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.makeCollectionViewFlowLayout())
        
        collectionView.backgroundColor = .clear
        self.view.addSubview(self.collectionView)
        self.collectionView.frame = self.view.frame
        
        collectionView.register(TotalAmountCell.self,
                                forCellWithReuseIdentifier: TotalAmountCell.cellId)
        collectionView.register(SummaryCell.self,
                                forCellWithReuseIdentifier: SummaryCell.cellId)
        collectionView.register(MultiplyTransactionCell.self,
                                forCellWithReuseIdentifier: MultiplyTransactionCell.cellId)
        collectionView.register(HeaderReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderReusableView.viewId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupFloatingButton() {
        self.view.addSubview(floatingButton)
        self.floatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.floatingButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            self.floatingButton.heightAnchor.constraint(equalToConstant: 60),
            self.floatingButton.widthAnchor.constraint(equalToConstant: self.collectionView.frame.width - 80)
        ])
        self.floatingButton.applyGradient(colors: [Resources.Colors.mainPositiveColor.cgColor,
                                                   Resources.Colors.mainNegativeColor.cgColor])
        self.floatingButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    private func setupBinders() {
        self.viewModel.$sections
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        self.collectionView.didSelectItemPublisher
            .sink { indexPath in
                print(indexPath)
                // open TransactionsVC
            }
            .store(in: &cancellables)
        
        self.collectionView.contentOffsetPublisher
            .sink { [weak self] contentOffset in
                self?.moveFloatingButton(contentOffset: contentOffset)
            }
            .store(in: &cancellables)
    }
    
    @objc func pressButton(button: UIButton) {
        
    }
    
    private func moveFloatingButton(contentOffset: CGPoint) {
        let transform = contentOffset.y > 0
        ? CGAffineTransform(translationX: 0, y: 100)
        : .identity
        UIView.animate(withDuration: 0.8,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            self.floatingButton.transform = transform
        }
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
            cell.cellModel = totalAmount
            cell.delegate = self
            return cell
        case .summarySection(let summary):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCell.cellId,
                                                                for: indexPath) as? SummaryCell else {
                return  UICollectionViewCell()
            }
            cell.cellModel = summary[indexPath.row]
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
                                                  withReuseIdentifier: HeaderReusableView.viewId,
                                                  for: indexPath) as? HeaderReusableView
            header?.setup(viewModel.sections[indexPath.section].title)
            return header ?? HeaderReusableView()
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
}

// MARK: - UICollectionViewCompositionalLayout

extension HomeViewController {
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
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
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

// MARK: - TotalAmountCellDelegate

extension HomeViewController: TotalAmountCellDelegate {
    func handleTapOnEyeButton() {
        self.viewModel.eyeButtonTapped()
    }
}
