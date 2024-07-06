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
    
    public let id: String
    public var name: String
    public var start: Int
    public var end: Int
    var selected = false
    
    public init(id: String, name: String, start: Int, end: Int) {
        self.id = id
        self.name = name
        self.start = start
        self.end = end
    }
    
    convenience init() {
        self.init(id: "", name: "", start: 0, end: 0)
    }
}
