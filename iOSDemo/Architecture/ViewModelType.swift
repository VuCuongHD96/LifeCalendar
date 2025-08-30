//
//  ViewModelType.swift
//  MovieSwiftUI
//
//  Created by Work on 15/03/2023.
//

import Combine

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output
}
