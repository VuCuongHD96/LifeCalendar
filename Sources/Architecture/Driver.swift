//
//  Driver.swift
//  MovieSwiftUI
//
//  Created by Work on 15/03/2023.
//

import Combine
import Foundation

typealias Driver<T> = AnyPublisher<T, Never>

extension Publisher {
    
    func asDriver() -> Driver<Output> {
        self.catch { _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    static func justDriver(_ output: Output) -> Driver<Output> {
       return Just(output).eraseToAnyPublisher()
   }
}
