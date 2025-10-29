//
//  EventCellData.swift
//
//
//  Created by Work on 25/6/24.
//

import SwiftUI

public struct EventCellData: Identifiable {
    
    public let id: String
    let name: String
    let description: String
    public var start: Date
    public var end: Date
    let locationInfo: EventLocationRowViewData?
    var selected = false
    let missionRateData: EventMissionRowViewData?
    var color: Color
    var hourDueration: TimeInterval {
        (end.timeIntervalSince1970 - start.timeIntervalSince1970) / 3600
    }
    let progress: Float
    
    public init(
        id: String,
        name: String,
        description: String,
        start: Date,
        end: Date,
        locationInfo: EventLocationRowViewData?,
        missionRateData: EventMissionRowViewData?,
        color: Color,
        progress: Float) {
            self.id = id
            self.name = name
            self.description = description
            self.start = start
            self.end = end
            self.locationInfo = locationInfo
            self.missionRateData = missionRateData
            self.color = color
            self.progress = progress
        }
}
