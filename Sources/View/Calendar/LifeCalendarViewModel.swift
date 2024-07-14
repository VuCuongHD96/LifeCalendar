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
        var onDragging = PassthroughSubject<Float, Never>()
        var onEndDragging = PassthroughSubject<Float, Never>()
    }
    
    class Output: ObservableObject {
        @Published var groupedEvents: [GroupEventViewData] = []
        @Published var hourArray: [String] = []
        @Published var eventOffset: EventOffset = .init()
        @Published var eventArray = [EventViewData]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        Just(eventArray)
            .assign(to: \.eventArray, on: output)
            .store(in: cancelBag)
        
        output.$eventArray
            .map {
                EventManager.groupEvent(eventArray: $0)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)
        
        Just(TimeManager.gethourArray())
            .assign(to: \.hourArray, on: output)
            .store(in: cancelBag)
        
//        input.$eventSelected
//            .map { _ in
//                EventOffset()
//            }
//            .assign(to: \.eventOffset, on: output)
//            .store(in: cancelBag)
        
        let eventIndexSelected =  input.$eventSelected
            .compactMap {
                eventArray.firstIndex(of: $0)
            }

        eventIndexSelected
            .handleEvents(receiveOutput: {
                output.eventArray.forEach {
                    $0.selected = false
                }
                output.eventArray[$0].selected = true
            })
            .map { _ in
                EventManager.groupEvent(eventArray: output.eventArray)
            }
            .assign(to: \.groupedEvents, on: output)
            .store(in: cancelBag)

        input.onDragging
            .sink {
//                print("--- debug --- eventOffset 1")
                output.eventOffset.offset = $0
            }
            .store(in: cancelBag)
        
        input.onEndDragging
            .sink {
//                print("--- debug --- eventOffset 2")
                output.eventOffset.lastOffset += $0
            }
            .store(in: cancelBag)
        
//        output.$eventOffset
//            .sink {
//                print("\n--- debug --- lastOffset = ", $0.lastOffset)
//                print("--- debug --- hour = ", $0.lastOffset / 80)
//                print("--- debug --- event sekected = ", input.eventSelected.name)
//            }
//            .store(in: cancelBag)
        
        Publishers.CombineLatest(eventIndexSelected, input.onEndDragging)
            .sink { (index, offset) in
                let hourChange = Int(offset / 80)
                output.eventArray[index].start += hourChange
                output.eventArray[index].end += hourChange
//                output.eventOffset.offset = 0
//                output.eventOffset.lastOffset = 0
//                print("--- debug --- totalOffset = ", output.eventOffset.totalOffset)
//                print("--- debug --- eventOffset 3")
                output.eventOffset.reset()
            }
            .store(in: cancelBag)
        
        return output
    }
}
