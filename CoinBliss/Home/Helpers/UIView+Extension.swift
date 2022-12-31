//
//  UIView+Extension.swift
//  CoinBliss
//
//  Created by F1xTeoNtTsS on 31/12/2022.
//

import UIKit

extension UIView {
    func setDefaultShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.23
        self.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        self.layer.shadowRadius = 3
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
