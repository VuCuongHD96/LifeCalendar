//
//  EventView.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI

struct EventView: View {
    
    struct Constant {
        static let hourUnit: CGFloat = 80
    }
    
    var event: EventViewData
    @State private var eventViewPadding = CGSize.zero
    @State private var slideViewPadding = CGSize.zero
    @State private var eventEndChanged: EventViewData?
    
    var body: some View {
        let dueration = event.end - event.start - 1
        eventPreview(dueration: dueration, color: Color.blue.opacity(0.5))
            .padding(.top, eventViewPadding.height)
            .overlay(alignment: .top) {
                if event.selected {
                    slideView(dueration: dueration)
                }
            }
            .modifier(EventChangeModifier(eventEndChanged: $eventEndChanged))
            .onAppear {
                eventEndChanged = nil
            }
    }
    
    private func eventPreview(dueration: Int, color: Color) -> some View {
        Rectangle()
            .fill(color)
            .overlay {
                VStack {
                    Text(event.name)
                    Text("start = \(event.start)")
                    Text("end   = \(event.end)")
                }
            }
            .frame(height: CGFloat(dueration + 1) * Constant.hourUnit + CGFloat(dueration))
            .padding(.top, Double(event.start) * Constant.hourUnit + Double(event.start))
    }
    
    private func slideView(dueration: Int) -> some View {
        eventPreview(dueration: dueration, color: Color.blue)
            .padding(.top, slideViewPadding.height)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        slideViewPadding.height = value.translation.height + eventViewPadding.height
                    }
                    .onEnded { value in
                        let slideChange = value.translation.height
                        let changeHour = Int(slideChange / Constant.hourUnit)
                        event.start += changeHour
                        event.end += changeHour
                        slideViewPadding.height = 0
                        eventEndChanged = event
                        eventEndChanged = nil
                    }
            )
    }
}

#Preview {
    let event = EventViewData(id: "1", name: "Event 1", start: 1, end: 3)
    return ScrollView {
        EventView(event: event)
    }
    .background(Color.green)
}
