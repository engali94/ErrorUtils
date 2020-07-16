//
//  ErrorUtilsTests.swift
//  ErrorUtilsTests
//
//  Created by Ali A. Hilal on 15 Jul 2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

import ErrorUtils
import XCTest

class ThrowableTests: XCTestCase {
    
    var sut: UrlParser!
    
    override func setUp() {
        sut = UrlParser()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testWhenErrorHappens_itShoudThrow() throws {
        assert(try sut.parse(url: "https://invalidweb.com"), throws: UrlParser.Error.invalidWebpage)
    }
    
    func testWhenErrorHappens_itShoudThrowWithUnderlyingError() throws {
        var thrownError: Swift.Error?
        
        XCTAssertThrowsError(try sut.save(html: "", to: "")) {
            thrownError = $0
        }
        
        struct Error: Swift.Error {}
        
        let expectedError = UrlParser.Error.savingFailed(Error())
        
        XCTAssertEqual(thrownError?.localizedDescription, expectedError.localizedDescription)
    }
            
    static var allTests = [
        ("testWhenErrorHappens_itShoudThrow", testWhenErrorHappens_itShoudThrow),
        ("testWhenErrorHappens_itShoudThrowWithUnderlyingError", testWhenErrorHappens_itShoudThrowWithUnderlyingError),
    ]
}
 
