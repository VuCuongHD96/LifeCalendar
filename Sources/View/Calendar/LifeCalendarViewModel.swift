//
//  LifeCalendarViewModel.swift
//
//
//  Created by Work on 4/7/24.
//

import Combine

struct LifeCalendarViewModel {
    
    var eventArray: [EventViewData]
}

extension LifeCalendarViewModel: ViewModel {
    
    class Input: ObservableObject {
        @Published var eventSelected: EventViewData = .init()
        var eventChanged = PassthroughSubject<EventViewData, Never>()
    }
    
    class Output: ObservableObject {
        @Published var groupedEvents: [GroupEventViewData] = []
        @Published var hourArray: [String] = []
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        Just(eventArray)
            .map {
                EventManager.groupEvent(eventArray: $0)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)
        
        Just(TimeManager.gethourArray())
            .assign(to: \.hourArray, on: output)
            .store(in: cancelBag)
        
        input.$eventSelected
            .compactMap {
                eventArray.firstIndex(of: $0)
            }
            .handleEvents(receiveOutput: {
                eventArray.forEach {
                    $0.selected = false
                }
                eventArray[$0].selected = true
            })
            .map { _ in
                EventManager.groupEvent(eventArray: eventArray)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)
        
        Publishers.CombineLatest( input.eventChanged, Just(eventArray))
            .map { (event, eventArray) in
                print("--- debug --- CombineLatest( input.$eventChanged, Just(eventArray))")
                var eventArrayCopy = eventArray
                eventArrayCopy[0] = event
                return eventArrayCopy
            }
            .map { _ in
                EventManager.groupEvent(eventArray: eventArray)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)
//        input.$eventChanged
//            .handleEvents(receiveOutput: {
//                eventArray[0] = $0
//            })
//            .store(in: cancelBag)
        
        return output
    }
}
