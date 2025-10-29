//
//  DeadlineHideTimeManager.swift
//  ToDoLife
//
//  Created by Work on 22/3/25.
//

import Foundation

struct DeadlineHideTimeManager: DeadlineManagerType {
    
    static func calculatorSameDay(startDate: Date) -> String {
        return "ngày \(startDate.day)/\(startDate.month)/\(startDate.year)"
    }
    
    static func calculatorSameMonth(startDate: Date, endDate: Date) -> String {
        return "ngày \(startDate.day) to \(endDate.day) tháng \(startDate.month)/\(startDate.year)"
    }
    
    static func calculatorSameYear(startDate: Date, endDate: Date) -> String {
        let startDateInfo = "ngày \(startDate.day)/\(startDate.month)"
        let endDateInfo = "ngày \(endDate.day)/\(endDate.month)"
        return "\(startDateInfo) to \(endDateInfo) năm \(startDate.year)"
    }
    
    static func calculatorNotSameYear(startDate: Date, endDate: Date) -> String {
        let startDateInfo = "ngày \(startDate.formattedNumericOmittedDate())"
        let endDateInfo = "ngày \(endDate.formattedNumericOmittedDate())"
        return "\(startDateInfo) to \(endDateInfo)"
    }
    
    static func getDeadLineText(startDate: Date, endDate: Date) -> String {
        switch (startDate.year == endDate.year,
                startDate.month == endDate.month,
                startDate.day == endDate.day) {
        case (true, true, true):
            return calculatorSameDay(startDate: startDate)
        case (true, true, false):
            return calculatorSameMonth(startDate: startDate, endDate: endDate)
        case (true, false, _):
            return calculatorSameYear(startDate: startDate, endDate: endDate)
        default:
            return calculatorNotSameYear(startDate: startDate, endDate: endDate)
        }
    }
}
