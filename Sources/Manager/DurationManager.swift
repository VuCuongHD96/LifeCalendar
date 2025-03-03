//
//  DurationManager.swift
//  LifeCalendar
//
//  Created by Work on 3/3/25.
//

import Foundation
import Then

struct DurationManager {
    
    static let durationLimit = 15.minutes.timeInterval
    
    static private let formatter = DateComponentsFormatter()
    
    static private func setupFormatter() {
        formatter.do {
            $0.unitsStyle = .full
            $0.calendar = Calendar.current
            $0.calendar?.locale = Locale(identifier: "vi")
        }
    }
    
    static func getDurationString(from duration: TimeInterval) -> String? {
        setupFormatter()
        
        if duration < durationLimit {
            return getFailDurationString(durationLimit: durationLimit)
        } else {
            return getDurationDetailString(from: duration)
        }
    }
    
    static func getDurationString(from duration: TimeInterval, durationLimit: TimeInterval) -> String? {
        setupFormatter()
        
        if duration < durationLimit {
            return getFailDurationString(durationLimit: durationLimit)
        } else {
            return getDurationDetailString(from: duration)
        }
    }
    
    static private func getDurationDetailString(from duration: TimeInterval) -> String? {
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
    
    static private func getFailDurationString(durationLimit: TimeInterval) -> String {
        return "Thời gian phải lớn hơn \(getDurationDetailString(from: durationLimit)!)"
    }
}
