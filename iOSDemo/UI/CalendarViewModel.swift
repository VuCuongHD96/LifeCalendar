//
//  CalendarViewModel.swift
//  iOSDemo
//
//  Created by sun on 30/8/25.
//

import LifeCalendar
import Combine
import Foundation

struct CalendarViewModel: ViewModelType {
    
    let event1 = EventCellData(id: "1", name: "event1", description: "description 1", start: .setTime(hour: 17), end: .setTime(hour: 17, minute: 45), locationInfo: nil, missionRateData: .init(isFinished: true, description: "3/3 missions"), color: .green)
    let event2 = EventCellData(id: "2", name: "event2", description: "description 2", start: .setTime(hour: 19), end: .setTime(hour: 21), locationInfo: .init(name: "My Hà Nội", address: "Hà Nội, Việt Nam"), missionRateData: .init(isFinished: false, description: "2/6 missions"), color: .blue)
    let event3 = EventCellData(id: "3", name: "event3", description: "description 3", start: .setTime(hour: 1), end: .setTime(hour: 3, minute: 0), locationInfo: .init(name: "Apple", address: "One Apple Park Way, Cupertino, California"), missionRateData: .init(isFinished: true, description: "8/8 missions"), color: .pink)
    let event4 = EventCellData(id: "4", name: "event4", description: "", start: .setTime(hour: 4), end: .setTime(hour: 6), locationInfo: .init(name: "Google", address: "Mountain View, California, Hoa Kỳ"), missionRateData: .init(isFinished: false, description: "5/10 missions"), color: .yellow)
}

extension CalendarViewModel {
    
    class Input: ObservableObject {
        let eventChangeTrigger = PassthroughSubject<EventCellData, Never>()
        @Published var eventSelected: EventCellData?
        @Published var dateSelected: Date = .now
    }
    
    class Output: ObservableObject {
        @Published var eventList: [EventCellData] = []
        @Published var groupedEvents: [GroupEventViewData] = []
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.$dateSelected
            .sink { _ in
                input.eventSelected = nil
            }
            .store(in: cancelBag)
        
        output.$eventList
            .map {
                EventManager.groupEvent(eventArray: $0)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)
        
        input.eventChangeTrigger
            .sink {
                let index = output.eventList.firstIndex(of: $0)
                output.eventList[index!] = $0
            }
            .store(in: cancelBag)
        
        Just([event1, event2, event3, event4])
            .assign(to: \.eventList, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
