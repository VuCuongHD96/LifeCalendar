//
//  EventViewData.swift
//
//
//  Created by Work on 25/6/24.
//

import SwiftUI

public struct EventViewData: Identifiable, Equatable {
    public let id = UUID.init()
    let name: String
    var start: Int
    var end: Int
    
    public init(name: String, start: Int, end: Int) {
        self.name = name
        self.start = start
        self.end = end
    }
    
    init() {
        self.init(name: "", start: 0, end: 0)
    }
}
