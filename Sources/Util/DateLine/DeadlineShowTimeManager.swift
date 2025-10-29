//
//  DeadlineShowTimeManager.swift
//  ToDoLife
//
//  Created by Work on 23/2/25.
//

import Foundation
import SwiftDate

public struct DeadlineShowTimeManager: DeadlineManagerType {
    
    public static func calculatorNotSameYear(startDate: Date, endDate: Date) -> String {
        let startDateInfo = "ngày \(startDate.formattedNumericOmittedDate())"
        let endDateInfo = "ngày \(endDate.formattedNumericOmittedDate())"
        return "\(startDateInfo) to \(endDateInfo)"
    }
    
    public static func calculatorSameYear(startDate: Date, endDate: Date) -> String {
        let startDateInfo = "ngày \(startDate.day)/\(startDate.month)"
        let endDateInfo = "ngày \(endDate.day)/\(endDate.month)"
        return "\(startDateInfo) to \(endDateInfo) năm \(startDate.year)"
    }
    
    public static func calculatorSameMonth(startDate: Date, endDate: Date) -> String {
        let startDateInfo = "\(startDate.getHourMinute()) ngày \(startDate.day)"
        let endDateInfo = "\(endDate.getHourMinute()) ngày \(endDate.day)"
        return "\(startDateInfo) to \(endDateInfo) tháng \(startDate.month)/\(startDate.year)"
    }
    
    static func calculatorSameDay(startDate: Date, endDate: Date) -> String {
        let startDateInfo = "\(startDate.getHourMinute())"
        let endDateInfo = "\(endDate.getHourMinute())"
        return "\(startDateInfo) to \(endDateInfo) ngày \(startDate.day)/\(startDate.month)/\(startDate.year)"
    }
    
    public static func getDeadLineText(startDate: Date, endDate: Date) -> String {
        let startDateLocalTime = startDate.adjustToLocalTime()
        let endDateLocalTime = endDate.adjustToLocalTime()
        switch (startDateLocalTime.year == endDateLocalTime.year,
                startDateLocalTime.month == endDateLocalTime.month,
                startDateLocalTime.day == endDateLocalTime.day) {
        case (true, true, true):
            return calculatorSameDay(startDate: startDateLocalTime, endDate: endDateLocalTime)
        case (true, true, false):
            return calculatorSameMonth(startDate: startDateLocalTime, endDate: endDateLocalTime)
        case (true, false, _):
            return calculatorSameYear(startDate: startDateLocalTime, endDate: endDateLocalTime)
        default:
            return calculatorNotSameYear(startDate: startDateLocalTime, endDate: endDateLocalTime)
        }
    }
}
