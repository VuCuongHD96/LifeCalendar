//
//  DeadlineText.swift
//  ToDoLife
//
//  Created by sun on 30/5/25.
//

import SwiftUI

public struct DeadlineText<T: DeadlineManagerType>: View {
    
    let startDate: Date
    let endDate: Date
    
    public init(startDate: Date, endDate: Date, isAdjustLocalTime: Bool = true) {
        self.startDate = isAdjustLocalTime ? startDate.adjustToLocalTime() : startDate
        self.endDate = isAdjustLocalTime ? endDate.adjustToLocalTime() : endDate
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "clock.badge")
                .resizable()
                .frame(width: 12, height: 12)
            Text(T.getDeadLineText(startDate: startDate, endDate: endDate))
        }
    }
}
