//
//  CalendarDateRangeViewModel.swift
//  LifeCalendar
//
//  Created by Work on 3/3/25.
//

import Combine
import Foundation
import Observation

struct CalendarDateRangeViewModel: ViewModel {
    
    class Input: ObservableObject {
        @Published var startDate = Date()
        @Published var endDate = Date()
    }
    
    class Output: ObservableObject {
        @Published var durationDescription: String? = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let durationPublisher = Publishers.CombineLatest(
            input.$startDate,
            input.$endDate
        ).map { startDate, endDate in
            endDate.timeIntervalSince(startDate)
        }
        
        let durationDescriptionPublisher = durationPublisher
            .map(DurationManager.getDurationString)
        
        durationDescriptionPublisher
            .assign(to: \.durationDescription, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
