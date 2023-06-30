//
//  AuthErrors.swift
//  KinzerskiyChat
//
//  Created by Mac Pro on 30.06.2023.
//

import Foundation

enum AuthErrors {
    case notFilled, invalidEmail, passwordNotMatched, unknownError, serverError
}

extension AuthErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .notFilled:
            return NSLocalizedString("Fill all fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Email field is invalid", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("Password fields does not match", comment: "")
        case .unknownError:
            return NSLocalizedString("Error is unknown", comment: "")
        case .serverError:
            return NSLocalizedString("Server error", comment: "")
        }
    }
    
    
}
