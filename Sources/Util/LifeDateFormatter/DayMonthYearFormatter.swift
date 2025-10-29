//
//  DayMonthYearFormatter.swift
//  ToDoLife
//
//  Created by Work on 3/11/24.
//

import Foundation

class DayMonthYearFormatter: DateFormatter, @unchecked Sendable {
   
    override init() {
        super.init()
        dateFormat = "dd/MM/yyyy"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
