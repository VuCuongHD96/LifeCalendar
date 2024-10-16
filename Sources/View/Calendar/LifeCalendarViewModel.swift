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
        @Published var hourChange = 0
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
            .sink { (oldValue, newValue) in
                if let oldValue = oldValue {
                    let oldEvent = output.eventArray[oldValue]
                    oldEvent.selected = false
                    output.eventArray[oldValue] = oldEvent
                }
                if let newValue = newValue {
                    let newEvent = output.eventArray[newValue]
                    newEvent.selected = true
                    output.eventArray[newValue] = newEvent
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
                }
            }
            .store(in: cancelBag)
        
        input.onEndDragging
            .map {
                Int($0 / 80)
            }
            .assign(to: \.hourChange, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
