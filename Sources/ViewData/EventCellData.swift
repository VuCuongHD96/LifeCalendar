//
//  EventCellData.swift
//
//
//  Created by Work on 25/6/24.
//

import SwiftUI

public struct EventCellData: Identifiable {

    public let id: String
    public let name: String
    public var start: Date
    public var end: Date
    public var selected = false
    public var color: Color
    public var hourDueration: TimeInterval {
        (end.timeIntervalSince1970 - start.timeIntervalSince1970) / 3600
    }
    
    public init(id: String, name: String, start: Date, end: Date, color: Color) {
        self.id = id
        self.name = name
        self.start = start
        self.end = end
        self.color = color
    }
}

extension EventCellData: Equatable {
    
    public static func == (lhs: EventCellData, rhs: EventCellData) -> Bool {
        lhs.id == rhs.id
    }
}
