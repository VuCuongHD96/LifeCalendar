// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct LifeCalendar: View {
    
    private struct Constant {
        static let hourHeight: CGFloat = 80
    }
    
    private let input: LifeCalendarViewModel.Input
    @ObservedObject private var output: LifeCalendarViewModel.Output
    private let cancelBag = CancelBag()
    
    public init(eventArray: [EventViewData]) {
        let viewModel = LifeCalendarViewModel(eventArray: eventArray)
        let input = LifeCalendarViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    public var body: some View {
        ScrollView {
            Text("Turn = \(output.trackIndex) --- event change = \(output.eventChanged.start)")
            HStack(alignment: .top) {
                TimeListView(hourArray: output.hourArray)
                DashListView(hourArray: output.hourArray)
                    .overlay(alignment: .top) {
                        eventListView
                    }
                    .padding(.top, 10)
            }
        }
        .modifier(EventSelectedModifier(event: input.eventSelected))
        .modifier(EventChangeModifier(eventEndChanged: output.eventChanged))
//        .modifier(HourChangeModifier(hour: output.hourChanged))
    }
    
    private var eventListView: some View {
        ZStack(alignment: .top) {
            ForEach(output.groupedEvents, id: \.id) { group in
                HStack(alignment: .top) {
                    ForEach(group.eventArray, id: \.id) { event in
                        eventItemView(event: event)
                    }
                }
            }
        }
    }
    
    private func eventItemView(event: EventViewData) -> some View {
        EventView(event: event)
            .frame(height: CGFloat(event.dueration) * Constant.hourHeight + CGFloat(event.dueration - 1))
            .offset(y: event.selected ? CGFloat(output.eventOffset.totalOffset) : 0)
            .background(
                EventView(event: event)
                    .opacity(event.selected ? 0.5 : 0)
            )
            .padding(.top, CGFloat(event.start) * Constant.hourHeight + CGFloat(event.start))
            .gesture(
                LongPressGesture()
                    .onEnded { _ in
                        input.eventSelected = event
                    }
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if event.selected {
                            let offsetHeight = Float(value.translation.height)
                            input.onDragging.send(offsetHeight)
                        }
                    }
                    .onEnded { value in
                        if event.selected {
                            let offsetHeight = Float(value.translation.height)
                            input.onEndDragging.send(offsetHeight)
                        }
                    }
            )
    }
}

#Preview {
    let event1 = EventViewData(id: "1", name: "event1", start: 17, end: 20)
    let event2 = EventViewData(id: "2", name: "event2", start: 19, end: 23)
    let event3 = EventViewData(id: "3", name: "event3", start: 1, end: 2)
    let event4 = EventViewData(id: "4", name: "event4", start: 2, end: 3)
    let eventArray = [event1, event2, event3, event4]
    
    return LifeCalendar(eventArray: eventArray)
        .onEventSelected {
            print("--- debug --- onEventSelected = ", $0.name)
        }
        .onEventChanged {
            print("--- debug --- onEventChanged = ", $0.name)
        }
        .onHourChanged {
            print("--- debug --- hour = ", $0)
        }
}
