//
//  SelfConfigurationCell.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 27.06.2023.
//

import UIKit

protocol SelfConfiguringCell {
    static var reusedId: String { get }
    func configure<U: Hashable>(with value: U)
}
