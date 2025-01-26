//
//  Publisher+.swift
//  ToDoLife
//
//  Created by Work on 18/8/24.
//

import Combine

extension Publisher {
    
    func mapToVoid() -> AnyPublisher<Void, Failure> {
        return map { _ in
            Void()
        }
        .eraseToAnyPublisher()
    }
    
    func mapToDriverVoid() -> Driver<Void> {
        mapToVoid()
            .asDriver()
    }
}
