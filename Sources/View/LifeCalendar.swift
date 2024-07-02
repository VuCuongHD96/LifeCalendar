// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct LifeCalendar: View {
    
    @State private var hourArray: [String] = []
    @State private var groupedEvents: [GroupEventViewData] = []
    
    let eventArray: [EventViewData]
    
    public init(eventArray: [EventViewData]) {
        self.eventArray = eventArray
    }
    
    public var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                TimeArrayView(hourArray: hourArray)
                DashArrayView(hourArray: hourArray)
                    .overlay(alignment: .top) {
                        eventArrayView
                    }
                    .padding(.top, 10)
            }
        }
        .onAppear {
            hourArray = TimeManager.gethourArray()
            groupedEvents = EventManager.groupEvent(eventArray: eventArray)
        }
    }
    
    private var eventArrayView: some View {
        ZStack(alignment: .top) {
            ForEach(groupedEvents, id: \.id) { group in
                HStack(alignment: .top) {
                    ForEach(group.eventArray) { event in
                        EventView(event: event)
                    }
                }
            }
        }
    }
}

#Preview {
    let event1 = EventViewData(name: "event1", start: 17, end: 20)
    let event2 = EventViewData(name: "event2", start: 19, end: 23)
    let event3 = EventViewData(name: "event3", start: 1, end: 2)
    let event4 = EventViewData(name: "event4", start: 2, end: 3)
    let eventArray = [event1, event2, event3, event4]
    
    return LifeCalendar(eventArray: eventArray)
        .onEventSelected {
            print("--- debug --- event = ", $0)
        }
}
