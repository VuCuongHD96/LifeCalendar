//
//  TimeManager.swift
//
//
//  Created by Work on 23/6/24.
//

import Foundation

struct TimeManager {
    
    static let hourSpacing = 60
    
    static func gethourArray() -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        var dateComponents = DateComponents()
        let calendar = Calendar.current
        let timeArray = Array(0..<24).compactMap { hour in
            dateComponents.hour = hour
            return calendar.date(from: dateComponents)
        }.map {
            dateFormatter.string(from: $0)
        }
        return timeArray
    }
}
