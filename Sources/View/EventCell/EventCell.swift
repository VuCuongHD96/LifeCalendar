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
        let eventStart = event.start
        let eventEnd = event.end
        let startOfSelectedDate = dateSelected.dateAtStartOf(.day)
        let endOfSelectedDate = dateSelected.dateAtEndOf(.day)
        
        let startDateRemake = eventStart < startOfSelectedDate ? startOfSelectedDate : eventStart
        let endDateRemake = eventEnd > endOfSelectedDate ? endOfSelectedDate : eventEnd
        
        let eventStartHour = CGFloat(startDateRemake.hour)
        let eventEndHour = CGFloat(endDateRemake.hour)
        
        let timeAlpha = endDateRemake - startDateRemake
        let hourAlpha = eventEndHour - eventStartHour - 2
        var cellHeight = timeAlpha.timeInterval / TimeManager.lineSpacing + hourAlpha
        if endOfSelectedDate == endDateRemake {
            cellHeight += 1
        }
        
        return EventCellInfo(event: event)
            .frame(height: cellHeight)
            .setupEventCellModifier(
                param: .init(
                    event: event,
                    dateSelected: dateSelected,
                    opacity: opacity,
                    progress: event.progress
                )
            )
    }
}
