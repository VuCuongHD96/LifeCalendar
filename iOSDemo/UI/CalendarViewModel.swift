//
//  CalendarViewModel.swift
//  iOSDemo
//
//  Created by sun on 30/8/25.
//

import LifeCalendar
import Combine
import Foundation
import SwiftDate

struct CalendarViewModel: ViewModelType {
    
    let event1 = EventCellData(id: "1", name: "event1", description: "description 1", start: .setTime(hour: 7), end: .setTime(hour: 7, minute: 45), locationInfo: nil, missionRateData: .init(isFinished: true, description: "3/3 missions"), color: .green, progress: 0.2)
    let event2 = EventCellData(id: "2", name: "event2", description: "description 2", start: .setTime(hour: 9), end: .setTime(hour: 11), locationInfo: .init(name: "My Hà Nội", address: "Hà Nội, Việt Nam"), missionRateData: .init(isFinished: false, description: "2/6 missions"), color: .blue, progress: 0.4)
    let event3 = EventCellData(id: "3", name: "event3", description: "description 3", start: .setTime(day: 26, hour: 23), end: .setTime(day: 27, hour: 3), locationInfo: .init(name: "Apple", address: "One Apple Park Way, Cupertino, California"), missionRateData: .init(isFinished: true, description: "8/8 missions"), color: .pink, progress: 0.6)
    let event4 = EventCellData(id: "4", name: "event4", description: "", start: .setTime(hour: 2), end: .setTime(hour: 4), locationInfo: .init(name: "Google", address: "Mountain View, California, Hoa Kỳ"), missionRateData: .init(isFinished: false, description: "5/10 missions"), color: .yellow, progress: 0.8)
}

extension CalendarViewModel {
    
    class Input: ObservableObject {
        let eventChangeTrigger = PassthroughSubject<EventChangedInfo, Never>()
        @Published var dateSelected: Date = .now
    }
    
    class Output: ObservableObject {
        @Published var eventList: [EventCellData] = []
        @Published var groupedEvents: [GroupEventViewData] = []
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        output.$eventList
            .map {
                EventManager.groupEvent(eventArray: $0)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)
        
        input.eventChangeTrigger
            .sink {
                let eventID = $0.eventID
                let index = output.eventList.firstIndex {
                    $0.id == eventID
                }
                let eventNeedUpdate = output.eventList[index!]
                let oldStartDate = eventNeedUpdate.start
                let newStartDate = oldStartDate + $0.minuteChange.minutes
                let oldEndDate = eventNeedUpdate.end
                let newEndDate = oldEndDate + $0.minuteChange.minutes
                var newEvent = eventNeedUpdate
                newEvent.start = newStartDate
                newEvent.end = newEndDate
                output.eventList[index!] = newEvent
            }
            .store(in: cancelBag)
        
        Publishers.CombineLatest(
            Just([event1, event2, event3, event4]),
            input.$dateSelected
        )
        .map { array, dateSelected in
            array.filter {
                let startOfDateSelected = dateSelected.dateAtStartOf(.day)
                let endOfDateSelected = dateSelected.dateAtEndOf(.day)
                return $0.end > startOfDateSelected && $0.start < endOfDateSelected
            }
        }
        .assign(to: \.eventList, on: output)
        .store(in: cancelBag)
        
        return output
    }
}
