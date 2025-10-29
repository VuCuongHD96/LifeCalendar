//
//  Date+.swift
//  ToDoLife
//
//  Created by Work on 3/10/24.
//

import Foundation

extension Date {
    
    var calendar: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        return calendar
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
    
    func adjustToLocalTime() -> Self {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        return self + timeZoneOffset
    }
    
    func toDateFormat(formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }
    
    var startOfDay: Date {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self)
    }
    
    var endOfDay: Date {
        return startOfDay.addingTimeInterval(1.days.timeInterval - 1)
    }
    
    func formattedNumericOmittedDate() -> String {
        formatted(date: .numeric, time: .omitted)
    }

    func getHourMinute() -> String {
        let timeComponents = calendar.dateComponents([.hour, .minute], from: self)
        let hour = timeComponents.hour ?? 0
        let minute = timeComponents.minute ?? 0
        return String(format: "%02d:%02d", hour, minute)
    }
}
