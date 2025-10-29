//
//  DeadlineText.swift
//  ToDoLife
//
//  Created by sun on 30/5/25.
//

import SwiftUI


struct DeadlineText: View {
    
    let startDate: Date
    let endDate: Date
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "clock.badge")
                .resizable()
                .frame(width: 12, height: 12)
            Text(DeadlineShowTimeManager.getDeadLineText(startDate: startDate, endDate: endDate))
        }
    }
}
