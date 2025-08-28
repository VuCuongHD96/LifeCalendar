//
//  Date+day.swift
//  LifeCalendar
//
//  Created by sun on 29/8/25.
//

import Foundation
import SwiftDate

extension Date {
    
    var tomorrow: Self {
        self + 1.days
    }
}
