//
//  EventMissionRowViewData.swift
//  LifeCalendar
//
//  Created by sun on 26/9/25.
//

import Foundation

public struct EventMissionRowViewData {
    
    let isFinished: Bool
    let description: String
    
    public init(isFinished: Bool, description: String) {
        self.isFinished = isFinished
        self.description = description
    }
}
