//
//  StackView+Extension.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 24.06.2023.
//

import UIKit

extension UIStackView {
    convenience init (arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
