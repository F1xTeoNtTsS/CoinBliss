//
//  AutoInvalidatingLayout.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 25/12/2022.
//

import UIKit

class AutoInvalidatingLayout: UICollectionViewFlowLayout {
    func widestCellWidth(bounds: CGRect) -> CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }

        let insets = collectionView.contentInset
        let width = bounds.width - insets.left - insets.right
        
        return width < 0 ? 0 : width
    }
    
    func updateEstimatedItemSize(bounds: CGRect) {
        estimatedItemSize = CGSize(
            width: widestCellWidth(bounds: bounds),
            height: .zero
        )
    }
    
    override func prepare() {
        super.prepare()

        let bounds = collectionView?.bounds ?? .zero
        updateEstimatedItemSize(bounds: bounds)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else {
            return false
        }

        let oldSize = collectionView.bounds.size
        guard oldSize != newBounds.size else { return false }

        updateEstimatedItemSize(bounds: newBounds)
        return true
    }
}
