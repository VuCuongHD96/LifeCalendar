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
        
        return output
    }
}
