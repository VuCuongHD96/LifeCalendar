//
//  CalendarViewModel.swift
//  iOSDemo
//
//  Created by sun on 30/8/25.
//

import LifeCalendar
import Combine

struct CalendarViewModel: ViewModelType {
    
    let event1 = EventCellData(id: "1", name: "event1", start: .setTime(hour: 17), end: .setTime(hour: 20))
    let event2 = EventCellData(id: "2", name: "event2", start: .setTime(hour: 19), end: .setTime(hour: 23))
    let event3 = EventCellData(id: "3", name: "event3", start: .setTime(hour: 1), end: .setTime(hour: 2))
    let event4 = EventCellData(id: "4", name: "event4", start: .setTime(hour: 2), end: .setTime(hour: 3))
}

extension CalendarViewModel {
    
    struct Input {
        
    }
    
    class Output: ObservableObject {
        @Published var eventList: [EventCellData] = []
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        Just([event1, event2, event3, event4])
            .assign(to: \.eventList, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
