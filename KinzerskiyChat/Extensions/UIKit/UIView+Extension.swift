//
//  UIView+Extension.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 29.06.2023.
//

import UIKit

extension UIView {
    
    
    func applyGradients(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.9515904958, green: 0.1241782211, blue: 0.7823629122, alpha: 1), endColor: #colorLiteral(red: 0.2426789893, green: 0.6047151527, blue: 0.7684348556, alpha: 1))
        
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer  {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
            
    }
}
