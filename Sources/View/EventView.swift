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
    
    let event: EventViewData
    @State private var selected = false
    @State private var eventViewPadding = CGSize.zero
    @State private var slideViewPadding = CGSize.zero
    
    var body: some View {
        let dueration = event.end - event.start - 1
        eventPreview(dueration: dueration, color: Color.blue.opacity(0.5))
            .padding(.top, eventViewPadding.height)
            .gesture(
                LongPressGesture()
                    .onEnded { _ in
                        selected.toggle()
                    }
            )
            .overlay(alignment: .top) {
                if selected {
                    slideView(dueration: dueration)
                }
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
                        eventViewPadding.height = slideViewPadding.height
                        dump(value)
                    }
            )
    }
}

#Preview {
    let event = EventViewData(name: "Event 1", start: 1, end: 3)
    return ScrollView {
        EventView(event: event)
    }
    .background(Color.green)
}
