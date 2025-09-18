//
//  EventCell.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI

struct EventCell: View {

    var event: EventCellData
    var opacity: Double? = 0.5
 
    var body: some View {
        let eventStartHour = CGFloat(event.start.adjustToLocalTime().hour)
        let eventStartMinute = CGFloat(event.start.adjustToLocalTime().minute)
        let cellHeight: CGFloat = event.dueration * TimeManager.lineSpacing + (event.dueration - 1) - 1
        
        Rectangle()
            .fill(Color.blue.opacity(opacity ?? 1))
            .overlay {
                VStack {
                    Text(event.name)
                    Text("start = \(event.start.adjustToLocalTime().hour)")
                    Text("end   = \(event.end.adjustToLocalTime().hour)")
                }
            }
            .frame(height: cellHeight)
            .padding(.top, eventStartHour * TimeManager.lineSpacing + eventStartHour)
            .padding(.top, eventStartMinute)
            .padding(.top, TimeManager.lineHeight)
    }
}
