//
//  EventCell.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI
import SwiftDate

struct EventCell: View {
    
    let event: EventCellData
    let opacity: Double
    
    var body: some View {
        let eventStart = event.start
        let eventEnd = event.end
        let startOfToday = Date().dateAtStartOf(.day)
        let endOfToday = Date().dateAtEndOf(.day)
        
        let startDateRemake = eventStart < startOfToday ? startOfToday : eventStart
        let endDateRemake = eventEnd > endOfToday ? endOfToday : eventEnd
        
        let eventStartHour = CGFloat(startDateRemake.hour)
        let eventStartMinute = CGFloat(startDateRemake.minute)
        let eventEndHour = CGFloat(endDateRemake.hour)
        
        let timeAlpha = endDateRemake - startDateRemake
        let hourAlpha = eventEndHour - eventStartHour - 2
        let cellHeight = timeAlpha.timeInterval / TimeManager.lineSpacing + hourAlpha
        
        return EventCellInfo(event: event)
            .frame(height: cellHeight)
            .setupLifeEventBackGroundModifier(
                param: .init(color: event.color, opacity: opacity)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .padding(.top, eventStartHour * TimeManager.lineSpacing + eventStartHour)
            .padding(.top, eventStartMinute)
            .padding(.top, TimeManager.lineHeight)
    }
}
