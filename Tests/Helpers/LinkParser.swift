//
//  UrlParser.swift
//  ErrorUtils-iOS
//
//  Created by Ali on 16.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

import Foundation
import ErrorUtils


struct UrlParser: Throwable {
    
    func parse(url: String) throws -> String {
        
        guard let url = URL(string: url) else {
            throw Error.invalidURL
        }
        
        return try execute(
            String(contentsOf: url),
            orThrow: Error.invalidWebpage
        )
        
     
    }
    
    func save(html: String, to file: String) throws  {
        return try execute(
            html.write(toFile: file, atomically: true, encoding: .utf8),
            errorTransform: { error -> Swift.Error in
                return Error.savingFailed(error)
        })
    }
}

extension UrlParser {
    enum Error: Swift.Error {
        case invalidURL
        case invalidWebpage
        case savingFailed(Swift.Error)
    }
}


extension UrlParser.Error: Equatable {
    static func == (lhs: UrlParser.Error, rhs: UrlParser.Error) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidWebpage, .invalidWebpage):
            return true
        case (.savingFailed, .savingFailed):
            return true
        default:
            return false
        }
    }
    
    
}
