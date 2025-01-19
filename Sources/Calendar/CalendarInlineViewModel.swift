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
    
    struct Input {
        var loadTrigger = PassthroughSubject<Void, Never>()
    }
    
    @Observable
    class Output {
        var weekdaySymbolList = [String]()
        var weekDayList: [Date] = []
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
        
        return output
    }
}
