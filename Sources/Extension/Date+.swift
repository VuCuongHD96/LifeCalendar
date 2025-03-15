//
//  Date+.swift
//  LifeCalendar
//
//  Created by Work on 15/3/25.
//

import Foundation
import SwiftDate

extension Date {
    
    var tomorrow: Self {
        self + 1.days
    }
}
