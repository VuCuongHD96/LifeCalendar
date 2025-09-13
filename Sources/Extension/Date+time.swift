//
//  Date+.swift
//  LifeCalendar
//
//  Created by Work on 15/3/25.
//

import Foundation

extension Date {
    
    public static func setTime(hour: Int, timeZone: String = "GMT") -> Self {
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
    
    public func setTime(hour: Int, timeZone: String = "GMT") -> Self {
        Self.setTime(hour: hour)
    }
    
    func adjustToLocalTime() -> Self {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        return self + timeZoneOffset
    }
}
