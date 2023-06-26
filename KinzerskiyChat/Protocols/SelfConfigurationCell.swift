//
//  SelfConfigurationCell.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 27.06.2023.
//

import Foundation

protocol SelfConfiguringCell {
    static var reusedId: String { get }
    func configure(with value: KChat)
}
