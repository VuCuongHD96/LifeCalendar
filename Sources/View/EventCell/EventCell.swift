//
//  EventCell.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI
import SwiftDate

struct EventCell: View {
    
    let dateSelected: Date
    let event: EventCellData
    let opacity: Double
    
    var body: some View {
        let eventStart = event.start.adjustToLocalTime()
        let eventEnd = event.end.adjustToLocalTime()
        let startOfSelectedDate = dateSelected.dateAtStartOf(.day)
        let endOfSelectedDate = dateSelected.dateAtEndOf(.day)
        
        let startDateRemake = eventStart < startOfSelectedDate ? startOfSelectedDate : eventStart
        let endDateRemake = eventEnd > endOfSelectedDate ? endOfSelectedDate : eventEnd
        
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
