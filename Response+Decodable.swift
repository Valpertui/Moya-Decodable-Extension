//
//  Response+Decodable.swift
//
//  Created by Valentin Pertuisot on 11/01/2016.
//

import Moya
import Decodable

public extension Response {
    
    /// Maps data received from the signal into an object which implements the Decodable protocol.
    /// If the conversion fails, the signal errors.
    public func mapObject<T: Decodable>() throws -> T {
        do {
            return try T.decode(try mapJSON())
        }
        catch {
            throw Error.JSONMapping(self)
        }
    }
    
    /// Maps data received from the signal into an array of objects which implement the Decodable
    /// protocol.
    /// If the conversion fails, the signal errors.
    public func mapObjectArray<T: Decodable>() throws -> [T] {
        do {
            return try [T].decode(try mapJSON())
        }
        catch {
            throw Error.JSONMapping(self)
        }
    }
    
}