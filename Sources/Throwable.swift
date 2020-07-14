//
//  Throwable.swift
//  ErrorUtils
//
//  Created by Ali on 15.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

@_exported import Foundation

protocol Throwable {
    
    func excute<T>(_ task: @autoclosure () throws -> T, orThrow errorExpression: @autoclosure () -> Error) throws -> T
    
    func excute<T>(_ task: @autoclosure () throws -> T, errorTransform: (Error) -> Error) throws -> T
}

extension Throwable {
    
    func excute<T>(_ task: @autoclosure () throws -> T, orThrow errorExpression: @autoclosure () -> Error) throws -> T {
        do {
            return try task()
         } catch {
             throw errorExpression()
         }
    }
    
    func excute<T>(_ task: @autoclosure () throws -> T, errorTransform: (Error) -> Error) throws -> T {
        do {
            return try task()
        } catch {
            throw errorTransform(error)
        }
    }
    
}
