//
//  DeadlineManagerType.swift
//  ToDoLife
//
//  Created by Work on 22/3/25.
//

import Foundation

public protocol DeadlineManagerType {
    static func calculatorNotSameYear(startDate: Date, endDate: Date) -> String
    static func calculatorSameYear(startDate: Date, endDate: Date) -> String
    static func calculatorSameMonth(startDate: Date, endDate: Date) -> String
    static func getDeadLineText(startDate: Date, endDate: Date) -> String
}
