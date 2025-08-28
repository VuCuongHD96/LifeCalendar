//
//  Date+.swift
//  LifeCalendar
//
//  Created by Work on 15/3/25.
//

import Foundation
import SwiftDate

extension Date {
    
    var tomorrow: Self {
        self + 1.days
    }
    
    static func setTime(hour: Int, timeZone: String = "GMT") -> Self {
        let component: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let calendar = Calendar.current
        var components = calendar.dateComponents(component, from: Self())
        
        components.timeZone = TimeZone(abbreviation: timeZone)
        components.hour = hour
        
        if let date = calendar.date(from: components) {
            return date
        } else {
            return .now
        }
    }
    
    mutating func setSelfTime(hour: Int, timeZone: String = "GMT") {
        let component: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let calendar = Calendar.current
        var components = calendar.dateComponents(component, from: Self())
        
        components.timeZone = TimeZone(abbreviation: timeZone)
        components.hour = hour
        
        if let date = calendar.date(from: components) {
            self = date
        } else {
            self = .now
        }
    }
}
