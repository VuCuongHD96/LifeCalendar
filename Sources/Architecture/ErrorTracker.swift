//
//  ErrorTracker.swift
//  MovieSwiftUI
//
//  Created by Work on 15/03/2023.
//

import Combine

typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher where Failure: Error {
    func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}
