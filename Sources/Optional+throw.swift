//
//  Optional+throw.swift
//  ErrorUtils
//
//  Created by Ali on 16.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

import Foundation

public extension Optional {
    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            throw errorExpression()
        }
    }
}
