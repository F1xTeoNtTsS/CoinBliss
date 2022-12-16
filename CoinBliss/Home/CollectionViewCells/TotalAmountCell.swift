//
//  TotalAmountCell.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 16/12/2022.
//

import UIKit

class TotalAmountCell: UICollectionViewCell {
    static let cellId = "TotalAmountCell"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(self.label)
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 3
        label.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup(_ totalAmount: TotalAmount) {
        self.label.text = String(totalAmount.total)
    }
}
