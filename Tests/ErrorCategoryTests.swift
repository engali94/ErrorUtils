//
//  File.swift
//  ErrorUtils
//
//  Created by Ali on 16.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

import XCTest
import ErrorUtils

class ErrorCategoryTests: XCTestCase {
    
    func testCorrectCategoryResolved() {
        let notRetrybale = ErrorStub.decodingFailure.resolveCategory()
        let retryable =  ErrorStub.noInternetConnection.resolveCategory()
        let requiresLogin = ErrorStub.notAuthorized.resolveCategory()
        XCTAssertEqual(notRetrybale, .notRetrybale)
        XCTAssertEqual(retryable, .retryable)
        XCTAssertEqual(requiresLogin, .requiresLogin)
    }
    
    
    static var allTests = [
        ("testCorrectCategoryResolved", testCorrectCategoryResolved),
    ]

    enum ErrorStub: Error {
        case noInternetConnection
        case decodingFailure
        case notAuthorized
    }

}

extension ErrorCategoryTests.ErrorStub: CategorizedError {
    var category: ErrorCategory {
        switch self {
        case .noInternetConnection:
            return .retryable
        case .decodingFailure:
            return .notRetrybale
        case .notAuthorized:
            return .requiresLogin
        }
    }
}
