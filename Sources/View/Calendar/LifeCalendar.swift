// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import SwiftDate

public struct LifeCalendar: View {
    
    let eventChangedHandler: EventHandler?
    let groupedEvents: [GroupEventViewData]
    
    @Binding var eventSelected: EventCellData?
    @State var eventOffset: EventOffset = .init()
    
    public init(
        eventSelected: Binding<EventCellData?>,
        groupedEvents: [GroupEventViewData],
        eventChangedHandler: EventHandler?
    ) {
        _eventSelected = eventSelected
        self.eventChangedHandler = eventChangedHandler
        self.groupedEvents = groupedEvents
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top) {
                TimeListView(hourArray: TimeManager.gethourArray())
                eventSideView
                    .padding(.top, 10)
            }
        }
    }
    
    private var eventSideView: some View {
        ZStack(alignment: .top) {
            DashListView(hourArray: TimeManager.gethourArray())
            eventListView
            if let eventSelected {
                EventCellOverlay(event: eventSelected, eventOffset: $eventOffset)
            }
        }
    }
    
    private var eventListView: some View {
        ZStack(alignment: .top) {
            ForEach(groupedEvents, id: \.id) { group in
                HStack(alignment: .top) {
                    ForEach(group.eventArray, id: \.id) { event in
                        eventRow(event: event)
                    }
                }
            }
        }
    }
    
    private func eventRow(event: EventCellData) -> some View {
        EventCell(event: event, opacity: 0.3)
            .highPriorityGesture(
                LongPressGesture(minimumDuration: 0.2, maximumDistance: 0.5)
                    .onEnded { _ in
                        eventSelected = event
                        eventOffset.reset()
                    }
            )
            .simultaneousGesture(
                EventCellDragGesture(eventOffset: $eventOffset)
                    .onEnded { _ in
                        updateEventSelected(newLastOffset: eventOffset.lastOffset)
                    }
            )
    }
    
    private func updateEventSelected(newLastOffset: CGFloat) {
        if var eventSelected {
            let hourChange = Int(newLastOffset / TimeManager.lineSpacing)
            let minuteChange = Int(newLastOffset) - hourChange
            let oldStartDate = eventSelected.start
            let newStartDate = oldStartDate + minuteChange.minutes
            eventSelected.start = newStartDate
            let oldEndDate = eventSelected.end
            let newEndDate = oldEndDate + minuteChange.minutes
            eventSelected.end = newEndDate
            eventChangedHandler?(eventSelected)
        }
        eventSelected = nil
    }
}
