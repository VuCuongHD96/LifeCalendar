//
//  DeadlineHideTimeManager.swift
//  ToDoLife
//
//  Created by Work on 22/3/25.
//

import Foundation

public struct DeadlineHideTimeManager: DeadlineManagerType {
    
    static func calculatorSameDay(startDate: Date) -> String {
        return "ngày \(startDate.day)/\(startDate.month)/\(startDate.year)"
    }
    
    public static func calculatorSameMonth(startDate: Date, endDate: Date) -> String {
        return "ngày \(startDate.day) to \(endDate.day) tháng \(startDate.month)/\(startDate.year)"
    }
    
    public static func calculatorSameYear(startDate: Date, endDate: Date) -> String {
        let startDateInfo = "ngày \(startDate.day)/\(startDate.month)"
        let endDateInfo = "ngày \(endDate.day)/\(endDate.month)"
        return "\(startDateInfo) to \(endDateInfo) năm \(startDate.year)"
    }
    
    public static func calculatorNotSameYear(startDate: Date, endDate: Date) -> String {
        let startDateInfo = "ngày \(startDate.formattedNumericOmittedDate())"
        let endDateInfo = "ngày \(endDate.formattedNumericOmittedDate())"
        return "\(startDateInfo) to \(endDateInfo)"
    }
    
    public static func getDeadLineText(startDate: Date, endDate: Date) -> String {
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
