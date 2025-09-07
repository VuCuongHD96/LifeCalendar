//
//  EventCellDragGesture.swift
//  LifeCalendar
//
//  Created by sun on 12/9/25.
//


import SwiftUI

struct EventCellDragGesture: Gesture {
    
    @Binding var eventOffset: EventOffset
    
    var body: some Gesture {
        DragGesture()
            .onChanged {
                eventOffset.offset = $0.translation.height
            }
            .onEnded { _ in
                eventOffset.lastOffset += eventOffset.offset
                eventOffset.offset = .zero
            }
    }
}
