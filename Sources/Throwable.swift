//
//  Throwable.swift
//  ErrorUtils
//
//  Created by Ali on 15.07.2020.
//  Copyright © 2020 ErrorUtils. All rights reserved.
//

@_exported import Foundation

public protocol Throwable {
    
    func execute<T>(_ task: @autoclosure () throws -> T,
                    orThrow errorExpression: @autoclosure () -> Error) throws -> T
    
    func execute<T>(_ task: @autoclosure () throws -> T,
                    errorTransform: (Error) -> Error) throws -> T
    
    @discardableResult
    func execute<T>(_ task: @autoclosure () throws -> T, orCaptureError: (@escaping(Error) -> Void)) -> T?
}

public extension Throwable {
    
    func execute<T>(_ task: @autoclosure () throws -> T,
                    orThrow errorExpression: @autoclosure () -> Error) throws -> T {
        do {
            return try task()
         } catch {
             throw errorExpression()
         }
    }
    
    func execute<T>(_ task: @autoclosure () throws -> T,
                    errorTransform: (Error) -> Error) throws -> T {
        do {
            return try task()
        } catch {
            throw errorTransform(error)
        }
    }
    
    func execute<T>(_ task: @autoclosure () throws -> T,
                    orCaptureError: (@escaping(Error) -> Void)) -> T? {
        do {
            return try task()
        } catch {
             orCaptureError(error)
        }
        return nil
    }
    
}



