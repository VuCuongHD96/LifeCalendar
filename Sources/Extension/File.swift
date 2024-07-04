//
//  File.swift
//  
//
//  Created by Work on 8/7/24.
//

import Combine

extension Publisher {
    
    func mapToVoid() -> AnyPublisher<Void, Failure> {
        self.map { _ in () }
            .eraseToAnyPublisher()
    }
}
