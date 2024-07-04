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
    
    @State private var eventEndChanged: EventViewData?
    
    @ObservedObject private var input: EventViewModel.Input
    @ObservedObject private var output: EventViewModel.Output
    private let cancelBag = CancelBag()
    
    init(event: EventViewData) {
        let viewModel = EventViewModel(event: event)
        let input = EventViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    var body: some View {
        eventPreview(color: Color.blue.opacity(0.5))
            .padding(.top, CGFloat(input.eventOffset.lastOffset))
            .overlay(alignment: .top) {
                if output.event.selected {
                    slideView()
                }
            }
            .modifier(EventChangeModifier(eventEndChanged: $eventEndChanged))
            .onAppear {
                eventEndChanged = nil
            }
    }
    
    private func eventPreview(color: Color) -> some View {
        Rectangle()
            .fill(color)
            .overlay {
                VStack {
                    Text(output.event.name)
                    Text("start = \(output.event.start)")
                    Text("end   = \(output.event.end)")
                }
            }
            .frame(height: CGFloat(output.eventPreviewHeight))
            .padding(.top, CGFloat(output.eventPreviewPaddingTop))
    }
    
    private func slideView() -> some View {
        eventPreview(color: Color.blue)
            .offset(y: CGFloat(input.eventOffset.offset))
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        input.eventOffset.offset = Float(value.translation.height) + input.eventOffset.lastOffset
                    }
                    .onEnded { value in
                        let slideChange = value.translation.height
                        let changeHour = Int(slideChange / Constant.hourUnit)
                        output.event.start += changeHour
                        output.event.end += changeHour
//                        input.eventViewPaddingTop = input.slideViewPaddingTop
//                        eventEndChanged = output.event
//                        eventEndChanged = nil
                        
                        input.eventOffset.offset = 0
                        input.eventOffset.lastOffset = Float(CGFloat(output.event.start) * Constant.hourUnit) + Float(output.event.start)
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
