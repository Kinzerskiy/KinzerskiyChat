//
//  UIImageView+Extension.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 24.06.2023.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
