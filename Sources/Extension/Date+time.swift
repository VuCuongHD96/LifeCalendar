//
//  Date+.swift
//  LifeCalendar
//
//  Created by Work on 15/3/25.
//

import Foundation

extension Date {
    
    public static func setTime(hour: Int, minute: Int = 0, second: Int = 0, timeZone: String = "GMT") -> Self {
        let component: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let calendar = Calendar.current
        var components = calendar.dateComponents(component, from: Self())
        
        components.timeZone = TimeZone(abbreviation: timeZone)
        components.hour = hour
        components.minute = minute
        components.second = second
        
        if let date = calendar.date(from: components) {
            return date
        } else {
            return .now
        }
    }
    
    func adjustToLocalTime() -> Self {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        return self + timeZoneOffset
    }
}
