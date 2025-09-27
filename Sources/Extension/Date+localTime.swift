//
//  Date+localTime.swift
//  LifeCalendar
//
//  Created by sun on 27/9/25.
//

import Foundation

extension Date {
    
    public func adjustToLocalTime() -> Self {
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        return self + timeZoneOffset
    }
}
