//
//  UIViewController+Extension.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 27.06.2023.
//

import UIKit

extension UIViewController {
    
    
     func configure<T: SelfConfiguringCell, U: Hashable>(collectionView: UICollectionView, cellType: T.Type, with value: U, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reusedId, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(cellType)")
        }
        cell.configure(with: value)
        return cell
    }
}


