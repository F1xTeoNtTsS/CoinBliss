//
//  TransactionsController.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 22/12/2022.
//

import UIKit
import Combine

final class TransactionsController: BaseViewController<TransactionsViewModel> {
    var router: TransactionsRouter?
    
    private var collectionView: UICollectionView!
    private var cancellables = Set<AnyCancellable>()
    
    override var prefersStatusBarHidden: Bool { true }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = Resources.Colors.mainPositiveColor
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupBinders()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        collectionView.backgroundColor = Resources.Colors.cellMainColor
        self.view.addSubview(self.collectionView)
        self.collectionView.frame = self.view.frame
        
        collectionView.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCell.cellId)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        switch viewModel.mode {
        case .fullscreen:
            self.setCloseButton()
            navigationController?.isNavigationBarHidden = true
        case .small:
            self.collectionView.isScrollEnabled = false
        }
    }
    
    private func setupBinders() {
        self.viewModel.$transactions
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func setCloseButton() {
        self.view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        self.closeButton.setDefaultShadow()
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension TransactionsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.mode == .fullscreen
        ? .init(top: 20, left: 0, bottom: 20, right: 0)
        : .init(top: 0, left: -20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 70
        return viewModel.mode == .fullscreen
        ? .init(width: view.frame.width - 20, height: height)
        : .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TransactionsController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.mode == .fullscreen ? viewModel.transactions.count : min(5, viewModel.transactions.count)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.cellId,
                                                            for: indexPath) as? TransactionCell else {
            return UICollectionViewCell()
        }
        DispatchQueue.main.async {
            cell.cellModel = self.viewModel.transactions[indexPath.row]
        }
        return cell
    }
}
