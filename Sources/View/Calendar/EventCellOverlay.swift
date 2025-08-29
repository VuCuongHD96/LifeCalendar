//
//  EventCellOverlay.swift
//  LifeCalendar
//
//  Created by sun on 29/8/25.
//

import SwiftUI

struct EventCellOverlay: View {
    
    typealias HeightHandler = (CGFloat) -> Void
    
    var event: EventCellData
    var totalOffset: CGFloat
    var onDraggingHandle: HeightHandler?
    var onEndDraggingHandle: HeightHandler?
    
    var body: some View {
        EventCell(event: event, opacity: 1)
            .padding(.top, totalOffset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let offsetHeight = value.translation.height
                        onDraggingHandle?(offsetHeight)
                    }
                    .onEnded { value in
                        let offsetHeight = value.translation.height
                        onEndDraggingHandle?(offsetHeight)
                    }
            )
    }
}

#Preview {
    
    let event = EventCellData(id: "1", name: "Event 1", start: .setTime(hour: 1), end: .setTime(hour: 3))
    
    EventCellOverlay(event: event, totalOffset: 0)
}
