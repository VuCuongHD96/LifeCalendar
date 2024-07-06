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
    
//    var event: EventViewData
    @State private var eventViewPadding = CGSize.zero
    @State private var slideViewPadding = CGSize.zero
//    @Binding var eventEndChanged: EventViewData
    
    let input: EventViewModel.Input
    @ObservedObject var output: EventViewModel.Output
    let cancelbag = CancelBag()
    
    init(event: EventViewData) {
        let viewModel = EventViewModel(event: event)
        let input = EventViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelbag)
        self.input = input
//        _eventEndChanged = eventEndChanged
    }
    
    var body: some View {
        let dueration = output.event.end - output.event.start - 1
//        let dueration = event.end - event.start - 1
        eventPreview(dueration: dueration, color: Color.blue.opacity(0.5))
            .padding(.top, eventViewPadding.height)
            .overlay(alignment: .top) {
                if output.event.selected {
                    slideView(dueration: dueration)
                }
            }
            .modifier(EventChangeModifier(eventEndChanged: output.eventChanged))
//            .gesture(
//                LongPressGesture()
//                    .onEnded { _ in
////                        input.eventSelected = event
//                    }
//            )

    }
    
    private func eventPreview(dueration: Int, color: Color) -> some View {
        Rectangle()
            .fill(color)
            .overlay {
                VStack {
                    Text(output.event.name)
                    Text("start = \(output.event.start)")
                    Text("end   = \(output.event.end)")
                    
//                    Text(output.event.name)
//                    Text("start = \(event.start)")
//                    Text("end   = \(event.end)")
                    
                    
                }
            }
            .frame(height: CGFloat(dueration + 1) * Constant.hourUnit + CGFloat(dueration))
            .padding(.top, Double(output.event.start) * Constant.hourUnit + Double(output.event.start))
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
                        print("--- debug --- slideView --- onEnded")
                        let slideChange = value.translation.height
                        let changeHour = Int(slideChange / Constant.hourUnit)
                        let eventChanged = output.event
                        eventChanged.start += changeHour
                        eventChanged.end += changeHour
                        
                        
                        input.eventChanged.send(eventChanged)
//                        input.eventChanged = eventChanged
//                        eventEndChanged = eventChanged
                        slideViewPadding.height = 0
//                        eventEndChanged = output.event
                    }
            )
    }
}

//#Preview {
//    let event = EventViewData(id: "1", name: "Event 1", start: 1, end: 3)
//    return ScrollView {
//        EventView(event: event, eventEndChanged: .constant(.init()))
//    }
//    .background(Color.green)
//}
