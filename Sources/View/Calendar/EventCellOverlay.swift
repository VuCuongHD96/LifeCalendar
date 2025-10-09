//
//  EventCellOverlay.swift
//  LifeCalendar
//
//  Created by sun on 29/8/25.
//

import SwiftUI
import SwiftDate

struct EventCellOverlay: View {
    
    typealias HeightHandler = (CGFloat) -> Void
    
    let dateSelected: Date
    var event: EventCellData
    @Binding var eventOffset: EventOffset
    var onEndDrag: VoidHandler?
    
    var body: some View {
        let startDate = event.start
        let endDate = event.end
        let dateAlpha = endDate - startDate
        let minuteAlpha: CGFloat = dateAlpha.timeInterval / TimeManager.lineSpacing
        let hourAlpha: CGFloat = minuteAlpha / TimeManager.lineSpacing - 2
        let cellHeight: CGFloat = minuteAlpha + hourAlpha
        let startOfSelectedDate = dateSelected.dateAtStartOf(.day)
        var minusMinute: CGFloat = 0
        if startDate < startOfSelectedDate {
            let minuteDate = startDate - startOfSelectedDate
            minusMinute = minuteDate.timeInterval / TimeManager.lineSpacing
        }
        
        return EventCellInfo(event: event)
            .frame(height: cellHeight)
            .setupEventCellModifier(
                param: .init(
                    event: event,
                    dateSelected: dateSelected,
                    opacity: 1
                )
            )
            .padding(.top, minusMinute)
            .padding(.top, eventOffset.totalOffset)
            .gesture(
                EventCellDragGesture(eventOffset: $eventOffset)
                    .onEnded { _ in
                        onEndDrag?()
                    }
            )
    }
}
