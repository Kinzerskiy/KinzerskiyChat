//
//  UserErrors.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 12.07.2023.
//

import Foundation

enum UserErrors {
    case notFilled, photoNotExist
}

extension UserErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Fill all fields", comment: "")
        case .photoNotExist:
            return  NSLocalizedString("User didn't select photo", comment: "")
        }
    }
}
