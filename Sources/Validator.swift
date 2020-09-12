//
//  Validator.swift
//  ErrorUtils
//
//  Created by Ali on 16.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

import Foundation

public struct Validator<Value> {
    
    public let closure: (Value) throws -> Void
    
    public init(closure: (@escaping(Value) throws -> Void)) {
        self.closure = closure
    }
    
    public static func validate(_ condition: @autoclosure () -> Bool,
                         errorMessage messageExpression: @autoclosure () -> String) throws {
        guard condition() else {
            let message = messageExpression()
            throw ValidationError(message: message)
        }
    }

    public static func validate<T>(_ value: T, using validator: Validator<T>) throws {
        try validator.closure(value)
    }
  
}

public struct ValidationError: LocalizedError {
    public let message: String
    public var errorDescription: String? { return message }
}


