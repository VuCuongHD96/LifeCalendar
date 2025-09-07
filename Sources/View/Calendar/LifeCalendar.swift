// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import SwiftDate

public struct LifeCalendar: View {
    
    private let cancelBag = CancelBag()
    
    let eventChangedHandler: EventHandler?
    let groupedEvents: [GroupEventViewData]
    @State var eventSelected: EventCellData?
    @State var eventOffset: EventOffset = .init()
    
    public init(groupedEvents: [GroupEventViewData], eventChangedHandler: EventHandler?) {
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
                eventCellOverlay(eventSelected: eventSelected)
            }
        }
    }
    
    private func eventCellOverlay(eventSelected: EventCellData) -> some View {
        EventCell(event: eventSelected, opacity: 1)
            .padding(.top, eventOffset.totalOffset)
            .gesture(
                EventCellDragGesture(eventOffset: $eventOffset)
                    .onEnded { _ in
                        updateEventSelected(newLastOffset: eventOffset.lastOffset)
                    }
            )
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
        EventCell(event: event)
            .gesture(
                LongPressGesture(minimumDuration: 0.1, maximumDistance: 0.2)
                    .sequenced(before: SpatialTapGesture(coordinateSpace: .local))
                    .onChanged { _ in
                        eventSelected = event
                        eventOffset.reset()
                    }
                    .simultaneously(with: EventCellDragGesture(eventOffset: $eventOffset)
                        .onEnded { _ in
                            updateEventSelected(newLastOffset: eventOffset.lastOffset)
                        }
                    )
            )
    }
    
    private func updateEventSelected(newLastOffset: CGFloat) {
        if var eventSelected {
            let hourChange = Int(newLastOffset / Constant.hourHeight)
            let oldStartHour = eventSelected.start.hour
            let newStartHour = oldStartHour + hourChange
            eventSelected.start = eventSelected.start.setTime(hour: newStartHour)
            let oldEndHour = eventSelected.end.hour
            let newEndHour = oldEndHour + hourChange
            eventSelected.end = eventSelected.end.setTime(hour: newEndHour)
            eventChangedHandler?(eventSelected)
        }
        eventSelected = nil
    }
}
