// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import SwiftDate

public struct LifeCalendar: View {
    
    let dateSelected: Date
    let eventChangedHandler: EventChangedHandler?
    let groupedEvents: [GroupEventViewData]
    let eventOnTap: EventHandler?
    
    @State var eventSelected: EventCellData?
    @State var eventOffset: EventOffset = .init()
    
    public init(
        dateSelected: Date,
        groupedEvents: [GroupEventViewData],
        eventChangedHandler: EventChangedHandler?,
        eventOnTap: EventHandler?
    ) {
        self.dateSelected = dateSelected
        self.eventChangedHandler = eventChangedHandler
        self.groupedEvents = groupedEvents
        self.eventOnTap = eventOnTap
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top) {
                TimeListView(hourArray: TimeManager.gethourArray())
                eventSideView
                    .padding(.top, 10)
            }
        }
        .onChange(of: dateSelected) { _, _ in
            eventSelected = nil
        }
    }
    
    private var eventSideView: some View {
        ZStack(alignment: .top) {
            DashListView(hourArray: TimeManager.gethourArray())
            eventListView
            if let eventSelected {
                EventCellOverlay(
                    dateSelected: dateSelected,
                    event: eventSelected,
                    eventOffset: $eventOffset,
                    onEndDrag: {
                        updateEventSelected(newLastOffset: eventOffset.lastOffset)
                    }
                )
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
        EventCell(dateSelected: dateSelected, event: event, opacity: 0.3)
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
            .onTapGesture {
                eventOnTap?(event)
            }
    }
    
    private func updateEventSelected(newLastOffset: CGFloat) {
        if let eventSelected {
            let hourChange = Int(newLastOffset / TimeManager.lineSpacing)
            let minuteChange = Int(newLastOffset) - hourChange
            let eventChangeInfo = EventChangedInfo(eventID: eventSelected.id, minuteChange: minuteChange)
            eventChangedHandler?(eventChangeInfo)
        }
        eventSelected = nil
    }
}
