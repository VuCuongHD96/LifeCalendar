//
//  Observable.swift
//  MovieSwiftUI
//
//  Created by Work on 15/03/2023.
//

import Combine

typealias Observable<T> = AnyPublisher<T, Error>

extension Observable {
    
    static func just(_ output: Output) -> Observable<Output> {
        return Just(output)
            .asObservable()
    }
}

extension Publisher where Failure == Never {
    
    func asObservable() -> Observable<Output> {
        self.setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
