//
//  EventCellData.swift
//
//
//  Created by Work on 25/6/24.
//

import SwiftUI

public struct EventCellData: Identifiable, Equatable {
    
    public static func == (lhs: EventCellData, rhs: EventCellData) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id: String
    public let name: String
    public var start: Date
    public var end: Date
    public var selected = false
    public var dueration: Int
    
    public init(id: String, name: String, start: Date, end: Date) {
        self.id = id
        self.name = name
        self.start = start
        self.end = end
        self.dueration = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)/3600
    }
    
    init() {
        self.init(id: "", name: "", start: .setTime(hour: 1), end: .setTime(hour: 2))
    }
}
