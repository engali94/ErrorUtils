//
//  OptionalOrThrowTests.swift
//  ErrorUtils
//
//  Created by Ali on 16.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

import XCTest
import ErrorUtils

class OptionalOrThrowTests: XCTestCase {
    
    var url: URL?
    
    func testWhenNil_itShouldThrow() {
        assert(try url.orThrow(UrlParser.Error.invalidURL), throws: (UrlParser.Error.invalidURL))
    }
    
    func testWhenNotNil_itShouldNotThrow() {
        url = URL(string: "https://alihilal.com")
        XCTAssertNoThrow(try url.orThrow(UrlParser.Error.invalidURL))
    }
    
    static var allTests = [
        ("testWhenNil_itShouldThrow", testWhenNil_itShouldThrow),
    ]

}
