//
//  CalendarInlineViewModel.swift
//  LifeCalendar
//
//  Created by Work on 19/1/25.
//

import Combine
import Observation
import Foundation

struct CalendarInlineViewModel: ViewModel {
    
    let calendarManager = CalendarManager()
    
    class Input: ObservableObject {
        var loadTrigger = PassthroughSubject<Void, Never>()
        @Published var dateSelected: Date = .now
        var nextWeekTrigger = PassthroughSubject<Void, Never>()
        var forwardWeekTrigger = PassthroughSubject<Void, Never>()
    }
    
    @Observable
    class Output {
        var weekdaySymbolList = [String]()
        var weekDayList: [Date] = []
        var dateSelectedString = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.loadTrigger
            .map {
                calendarManager.weekdaySymbolsStarting(from: .monday, localeIdentifier: .vi)
            }
            .assign(to: \.weekdaySymbolList, on: output)
            .store(in: cancelBag)
        
        input.nextWeekTrigger
            .map { _ in
                CalendarManager.getNextWeekDate(from: input.dateSelected)
            }
            .sink {
                input.dateSelected = $0
            }
            .store(in: cancelBag)

        input.forwardWeekTrigger
            .map { _ in
                CalendarManager.getForwarkWeekDate(from: input.dateSelected)
            }
            .sink {
                input.dateSelected = $0
            }
            .store(in: cancelBag)
        
        input.$dateSelected
            .map {
                calendarManager.getWeekDateList(from: $0)
            }
            .assign(to: \.weekDayList, on: output)
            .store(in: cancelBag)
        
        input.$dateSelected
            .map {
                CalendarManager.createDateString(from: $0, localeIdentifier: .vi)
            }
            .assign(to: \.dateSelectedString, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
