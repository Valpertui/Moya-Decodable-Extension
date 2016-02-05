//
//  SignalProducer+Decodable.swift
//
//  Created by Valentin Pertuisot on 29/10/2015.
//

import ReactiveCocoa
import Moya
import Decodable

extension SignalProducerType where Value == Moya.Response, Error == Moya.Error {
    
    /// Maps data received from the signal into a JSON object. If the conversion fails, the signal errors.
    public func mapObject<O: Decodable>(objectClass : O.Type) -> SignalProducer<O, Error> {
        return producer.flatMap(.Latest) { response -> SignalProducer<O, Error> in
            return unwrapThrowable { try response.mapObject() }
        }
    }
    
    public func mapObjectArray<O: Decodable>(objectClass : O.Type) -> SignalProducer<[O], Error> {
        return producer.flatMap(.Latest) { response -> SignalProducer<[O], Error> in
            return unwrapThrowable { try response.mapObjectArray() }
        }
    }
}

private func unwrapThrowable<T>(throwable: () throws -> T) -> SignalProducer<T, Error> {
    do {
        return SignalProducer(value: try throwable())
    } catch {
        return SignalProducer(error: error as! Error)
    }
}