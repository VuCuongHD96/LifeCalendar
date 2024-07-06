// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct LifeCalendar: View {
    
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
//        .onEventChanged {
//            print("\n\n\n--- debug --- onEventChanged = ")
//            print("--- debug --- name = ", $0.name)
//            print("--- debug --- start = ", $0.start)
//            print("--- debug --- end = ", $0.end)
//            input.eventChanged.send($0)
//        }
    }
    
    private var eventListView: some View {
        ZStack(alignment: .top) {
            ForEach(output.groupedEvents, id: \.id) { group in
                HStack(alignment: .top) {
                    ForEach(group.eventArray, id: \.id) { event in
                        EventView(event: event)
                            .gesture(
                                LongPressGesture()
                                    .onEnded { _ in
                                        input.eventSelected = event
                                    }
                            )
                    }
                }
            }
        }
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
}
