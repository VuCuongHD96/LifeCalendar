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
    
    let today = Date.now
    let calendarManager = CalendarManager()

    class Input: ObservableObject {
        var loadTrigger = PassthroughSubject<Void, Never>()
        @Published var dateSelected: Date = .now
    }
    
    @Observable
    class Output {
        var weekdaySymbolList = [String]()
        var weekDayList: [Date] = []
        var dateSelectedString = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let weekdaySymbolList = calendarManager.weekdaySymbolsStarting(from: .monday, localeIdentifier: .vi)
        Just(weekdaySymbolList)
            .assign(to: \.weekdaySymbolList, on: output)
            .store(in: cancelBag)
        
        let weekDayList = calendarManager.getWeekDateList(from: today)
        Just(weekDayList)
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
