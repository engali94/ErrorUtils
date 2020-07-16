//
//  ErrorCategory.swift
//  ErrorUtils
//
//  Created by Ali on 15.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

@_exported import Foundation

public enum ErrorCategory {
    case notRetrybale
    case retryable
    case requiresLogin
}

public protocol CategorizedError: Error {
    var category: ErrorCategory { get }
}

public extension Error {
    
    func resolveCategory() -> ErrorCategory {
        guard let categorized = self as? CategorizedError else {
            return .notRetrybale
        }
        return categorized.category
    }
}
