//
//  Observable.swift
//  MovieSwiftUI
//
//  Created by Work on 15/03/2023.
//

import Combine

public typealias Observable<T> = AnyPublisher<T, Error>

extension Observable {
    
    public static func just(_ output: Output) -> Observable<Output> {
        return Just(output)
            .asObservable()
    }
}

extension Publisher where Failure == Never {
    
    public func asObservable() -> Observable<Output> {
        self.setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
