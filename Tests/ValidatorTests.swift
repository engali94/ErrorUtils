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
        XCTAssertThrowsError(try validate("123", using: .password))
        try validate("123BFg4567", using: .password)
    }
    
    func testUppercasedCharacterRequirement() throws {
        XCTAssertThrowsError(try validate("abcdefg", using: .password))
        try validate("Abcdefg", using: .password)
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
}
