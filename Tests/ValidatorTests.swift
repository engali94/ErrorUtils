//
//  ValidatorTests.swift
//  ErrorUtils
//
//  Created by Ali on 16.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

import XCTest
import ErrorUtils

class ValidatorTests: XCTestCase {
    
    func testLengthRequirement() throws {
        XCTAssertThrowsError(try Validator<String>.validate("123", using: .password))
        try Validator<String>.validate("123BFg4567", using: .password)
    }
    
    func testUppercasedCharacterRequirement() throws {
        XCTAssertThrowsError(try Validator<String>.validate("abcdefg", using: .password))
        try Validator<String>.validate("Abcdefg", using: .password)
    }
    
    static var allTests = [
          ("testLengthRequirement", testLengthRequirement),
          ("testUppercasedCharacterRequirement", testUppercasedCharacterRequirement),
      ]
}

extension Validator where Value == String {
    static var password: Validator {
        return Validator { string in
            try validate(
                string.count >= 7,
                errorMessage: "Password must contain min 7 characters"
            )

            try validate(
                string.lowercased() != string,
                errorMessage: "Password must contain an uppercased character"
            )

            try validate(
                string.uppercased() != string,
                errorMessage: "Password must contain a lowercased character"
            )
        }
    }
    
    static var username: Validator {
        return Validator { string in
            try validate(string.count >= 3, errorMessage: "Username must have at least 3 characters")
        }
    }
}
