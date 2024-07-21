//
//  LifeCalendarViewModel.swift
//
//
//  Created by Work on 4/7/24.
//

import Combine

struct LifeCalendarViewModel {
    
    let eventArray: [EventViewData]
}

extension LifeCalendarViewModel: ViewModel {
    
    class Input: ObservableObject {
        @Published var eventSelected: EventViewData = .init()
        var onDragging = PassthroughSubject<Float, Never>()
        var onEndDragging = PassthroughSubject<Float, Never>()
    }
    
    class Output: ObservableObject {
        @Published var groupedEvents: [GroupEventViewData] = []
        @Published var hourArray: [String] = []
        @Published var eventOffset: EventOffset = .init()
        @Published var eventArray = [EventViewData]()
        var eventIndexSelected: Int?
        var eventChanged: EventViewData = .init()
        var trackIndex = 0
        var hourChanged = 0
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        Just(eventArray)
            .assign(to: \.eventArray, on: output)
            .store(in: cancelBag)
        
        output.$eventArray
            .map {
                EventManager.groupEvent(eventArray: $0)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)
        
        Just(TimeManager.gethourArray())
            .assign(to: \.hourArray, on: output)
            .store(in: cancelBag)
        
        let eventIndexSelected = input.$eventSelected
            .compactMap {
                eventArray.firstIndex(of: $0)
            }
        
        eventIndexSelected
            .sink { 
                output.eventIndexSelected = $0
            }
            .store(in: cancelBag)
        
        eventIndexSelected
            .scan((nil, nil)) { previous, newValue in
                return (previous.1, newValue)
            }
            .compactMap { $0 }
            .sink { (oldIndex, newIndex) in
                if let oldIndex = oldIndex {
                    let oldEvent = output.eventArray[oldIndex]
                    oldEvent.selected = false
                    output.eventArray[oldIndex] = oldEvent
                }
                if let newIndex = newIndex {
                    let newEvent = output.eventArray[newIndex]
                    newEvent.selected = true
                    output.eventArray[newIndex] = newEvent
                }
            }
            .store(in: cancelBag)
        
        input.onDragging
            .sink {
                output.eventOffset.offset = $0
            }
            .store(in: cancelBag)
        
        input.onEndDragging
            .sink {
                output.eventOffset.lastOffset += $0
                output.eventOffset.reset()
            }
            .store(in: cancelBag)
        
        input.onEndDragging
            .sink { offset in
                if let index = output.eventIndexSelected {
                    let hourChange = Int(offset / 80)
                    let eventChanged = output.eventArray[index]
                    eventChanged.start += hourChange
                    eventChanged.end += hourChange
                    output.eventArray[index] = eventChanged
                    output.hourChanged = hourChange
                    output.trackIndex += 1
                    output.eventChanged = eventChanged
                    print("\n--- debug --- ViewModel --- index \(output.trackIndex) --- hourChanged = ", hourChange)
                }
            }
            .store(in: cancelBag)
        
        return output
    }
}
