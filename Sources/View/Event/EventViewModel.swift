//
//  EventViewModel.swift
//
//
//  Created by Work on 6/7/24.
//

import Combine

struct EventViewModel {
    
    let event: EventViewData
}

extension EventViewModel: ViewModel {
    
    struct Input {
         var eventChanged = PassthroughSubject<EventViewData, Never>()
    }
    
    class Output: ObservableObject {
        @Published var event = EventViewData()
        @Published var eventChanged: EventViewData?
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        Just(event)
            .assign(to: \.event, on: output)
            .store(in: cancelBag)
        
        input.eventChanged
            .compactMap { $0 }
            .assign(to: \.eventChanged, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
