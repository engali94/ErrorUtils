//
//  AsNSError.swift
//  ErrorUtils
//
//  Created by Ali on 16.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

import Foundation

public extension Error {
    func asNSError() -> NSError? {
        guard let nsError = self as? NSError else { return nil }
        return nsError
    }
}
