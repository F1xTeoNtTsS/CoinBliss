//
//  TransactionsController.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 22/12/2022.
//

import UIKit

enum Mode {
    case fullscreen, small
}

final class TransactionsController: UICollectionViewController {
    
    var transactions: [Transaction] = []
    var count: Int = 0
    
    private var mode: Mode?
    override var prefersStatusBarHidden: Bool { return true }
    
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
        switch mode {
        case .fullscreen:
            setCloseButton()
            navigationController?.isNavigationBarHidden = true
        case .small:
            self.collectionView.isScrollEnabled = false
        default:
            break
        }
        
        collectionView.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCell.cellId)
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    private func setCloseButton() {
        self.view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .fullscreen {
            return transactions.count
        }
        return min(5, transactions.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.cellId,
                                                      for: indexPath) as! TransactionCell
        DispatchQueue.main.async {
            cell.setup(self.transactions[indexPath.row])
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - present full transaction VC logic
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init(collectionViewLayout: AutoInvalidatingLayout())
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TransactionsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 20, left: 20, bottom: 20, right: 20)
        }
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 70
        if mode == .small {
            return .init(width: view.frame.width, height: height)
        }
        return .init(width: view.frame.width - 40, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
