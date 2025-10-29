//
//  DurationFormatter.swift
//  ToDoLife
//
//  Created by Work on 28/11/24.
//

import Foundation

struct DurationFormatter {
    
    static let durationLimit = 15.minutes.timeInterval
    
    static private let formatter = DateComponentsFormatter()
    
    static private func setupFormatter() {
        formatter.unitsStyle = .full
        formatter.calendar = Calendar.current
        formatter.calendar?.locale = Locale(identifier: "vi")
    }
    
    static func getDurationString(from duration: TimeInterval) -> String? {
        setupFormatter()
        
        if duration < durationLimit {
            return getFailDurationString()
        } else {
            return getSuccessDurationString(from: duration)
        }
    }
    
    static private func getSuccessDurationString(from duration: TimeInterval) -> String? {
        var calendarUnit: NSCalendar.Unit = []
        switch duration {
        case 1.years.timeInterval...:
            calendarUnit = [.year, .month]
        case 1.months.timeInterval...:
            calendarUnit = [.month, .day]
        case 1.days.timeInterval...:
            calendarUnit = [.day, .hour]
        case 1.hours.timeInterval...:
            calendarUnit = [.hour, .minute]
        default:
            break
        }
        
        formatter.allowedUnits = calendarUnit
        
        if let formattedString = formatter.string(from: duration) {
            return "Thời gian: \(formattedString)"
        } else {
            return nil
        }
    }
    
    static private func getFailDurationString() -> String {
        return "Thời gian phải lớn hơn 15'"
    }
}
