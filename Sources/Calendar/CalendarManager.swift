//
//  CalendarManager.swift
//  LifeCalendar
//
//  Created by Work on 19/1/25.
//

import Foundation
import SwiftDate

struct CalendarManager {
    
    enum SymbolDay: Int {
        case monday = -1
        case sunday = -2
    }
    
    enum LocaleIdentifier: String {
        case us = "en_US"
        case vi = "vi_VN"
    }
    
    private init() { }
    
    static func createDateString(from date: Date, localeIdentifier: LocaleIdentifier) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM, yyyy"
        formatter.locale = Locale(identifier: localeIdentifier.rawValue)
        return formatter.string(from: date)
    }
    
    static func weekdaySymbolsStarting(from symbolDay: SymbolDay, localeIdentifier: LocaleIdentifier) -> [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: localeIdentifier.rawValue)
        let calendar = Calendar.current
        dateFormatter.calendar = calendar
        let symbols = dateFormatter.shortWeekdaySymbols ?? []
        let mondayIndex = (calendar.firstWeekday + symbolDay.rawValue) % 7
        return Array(symbols[mondayIndex...] + symbols[..<mondayIndex])
    }
    
    static func getWeekDateList(from date: Date) -> [Date] {
        let startOfWeek = date.dateAt(.startOfWeek)
        let weekDays = (0..<7).map { startOfWeek + $0.days }
        return weekDays
    }
    
    static func getNextWeekDate(from date: Date) -> Date {
        return date + 1.weeks
    }
    
    static func getForwarkWeekDate(from date: Date) -> Date {
        return date - 1.weeks
    }
}
