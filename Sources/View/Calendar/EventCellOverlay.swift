//
//  EventCellOverlay.swift
//  LifeCalendar
//
//  Created by sun on 29/8/25.
//

import SwiftUI

struct EventCellOverlay: View {
    
    typealias HeightHandler = (CGFloat) -> Void
    
    let dateSelected: Date
    var event: EventCellData
    @Binding var eventOffset: EventOffset
    
    var body: some View {
        EventCell(dateSelected: dateSelected, event: event, opacity: 1)
            .padding(.top, eventOffset.totalOffset)
            .gesture(
                EventCellDragGesture(eventOffset: $eventOffset)
            )
    }
}
