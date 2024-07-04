//
//  EventViewData.swift
//
//
//  Created by Work on 25/6/24.
//

import SwiftUI

public class EventViewData: Identifiable, Equatable {
    
    public static func == (lhs: EventViewData, rhs: EventViewData) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id = UUID.init()
    let name: String
    var start: Int
    var end: Int
    
    public init(name: String, start: Int, end: Int) {
        self.name = name
        self.start = start
        self.end = end
    }
    
    convenience init() {
        self.init(name: "", start: 0, end: 0)
    }
}
