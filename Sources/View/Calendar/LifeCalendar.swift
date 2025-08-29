// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import SwiftDate

public struct LifeCalendar: View {
    
    private let input: LifeCalendarViewModel.Input
    @ObservedObject private var output: LifeCalendarViewModel.Output
    private let cancelBag = CancelBag()
    
    let eventChangedHandler: EventHandler?
    
    public init(eventArray: [EventCellData], eventChangedHandler: EventHandler?) {
        let viewModel = LifeCalendarViewModel(eventArray: eventArray)
        let input = LifeCalendarViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        self.eventChangedHandler = eventChangedHandler
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            HStack(alignment: .top) {
                TimeListView(hourArray: output.hourArray)
                eventSideView
                    .padding(.top, 10)
            }
            .onReceive(output.$eventChanged) {
                if let eventChanged = $0 {
                    eventChangedHandler?(eventChanged)
                }
            }
        }
    }
    
    private var eventSideView: some View {
        ZStack(alignment: .top) {
            DashListView(hourArray: output.hourArray)
            eventListView
            if let event = input.eventSelected {
                EventCellOverlay(
                    event: event,
                    totalOffset: output.eventOffset.totalOffset,
                    onDraggingHandle: {
                        input.onDragging.send($0)
                    }, onEndDraggingHandle: {
                        input.onEndDragging.send($0)
                    }
                )
            }
        }
    }
    
    private var eventListView: some View {
        ZStack(alignment: .top) {
            ForEach(output.groupedEvents, id: \.id) { group in
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
                LongPressGesture()
                    .onEnded { _ in
                        input.eventSelected = event
                    }
            )
    }
}

#Preview {
    let event1 = EventCellData(id: "1", name: "event1", start: .setTime(hour: 17), end: .setTime(hour: 20))
    let event2 = EventCellData(id: "2", name: "event2", start: .setTime(hour: 19), end: .setTime(hour: 23))
    let event3 = EventCellData(id: "3", name: "event3", start: .setTime(hour: 1), end: .setTime(hour: 2))
    let event4 = EventCellData(id: "4", name: "event4", start: .setTime(hour: 2), end: .setTime(hour: 3))
    let eventArray = [event1, event2, event3, event4]
    
    LifeCalendar(
        eventArray: eventArray,
        eventChangedHandler: {
            print("--- debug --- eventChangedHandler = ", $0)
        }
    )
    .onEventSelected {
        print("--- debug --- onEventSelected = ", $0.name)
    }
    .onEventChanged {
        print("--- debug --- onEventChanged = ", $0.name)
    }
}
