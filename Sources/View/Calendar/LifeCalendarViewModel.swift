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
        let loadTrigger = PassthroughSubject<Void, Never>()
        @Published var eventSelected: EventViewData?
        let eventChange = PassthroughSubject<EventViewData?, Never>()
    }
    
    class Output: ObservableObject {
        @Published var groupedEvents: [GroupEventViewData] = []
        @Published var hourArray: [String] = []
        @Published var eventArray = [EventViewData]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        output.$eventArray
            .map {
                EventManager.groupEvent(eventArray: $0)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)

        Just(eventArray)
            .assign(to: \.eventArray, on: output)
            .store(in: cancelBag)
        
        Just(TimeManager.gethourArray())
            .assign(to: \.hourArray, on: output)
            .store(in: cancelBag)
        
        let eventIndexSelected =  input.$eventSelected
            .compactMap { $0 }
            .compactMap {
                output.eventArray.firstIndex(of: $0)
            }
        
        input.$eventSelected
            .flatMap { _ in
                eventIndexSelected
            }
            .sink {
                output.eventArray.forEach {
                    $0.selected = false
                }
                let abc = output.eventArray[$0]
                    abc.selected.toggle()
                output.eventArray[$0] = abc
            }
            .store(in: cancelBag)
        
        let eventChangeUnwrapped =  input.eventChange
            .compactMap { $0 }

        Publishers.Zip(
            eventIndexSelected,
            eventChangeUnwrapped
        )
        .sink { (index, eventChange) in
            output.eventArray[index].start = eventChange.start
            output.eventArray[index].end = eventChange.end
        }
        .store(in: cancelBag)
        
//        input.eventChange
//        
//            .sink {
//                print("\n\n--- debug --- eventChange info")
//                print("--- debug --- eventChange name = ", $0.name)
//                print("--- debug --- eventChange start = ", $0.start)
//                print("--- debug --- eventChange end = ", $0.end)
//            }
//            .store(in: cancelBag)
        
        return output
    }
}
