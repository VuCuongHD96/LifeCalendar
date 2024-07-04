//
//  EventViewModel.swift
//
//
//  Created by Work on 5/7/24.
//

import Combine

struct EventViewModel {
    
    struct Constant {
        static let hourUnit = 80
    }
    
    let event: EventViewData
}

struct EventSlideOffset {
    
    var offset: Float
    var lastOffset: Float
    
    init(offset: Float, lastOffset: Float) {
        self.offset = offset
        self.lastOffset = lastOffset
    }
    
    init() {
        self.init(offset: .zero, lastOffset: .zero)
    }
}

extension EventViewModel: ViewModel {
    
    class Input: ObservableObject {
        let loadTrigger = Driver.just(Void())
        @Published var slideViewPaddingTop = 0
        @Published var eventViewPaddingTop = 0
        @Published var eventOffset: EventSlideOffset = .init()
        var hourChange = PassthroughSubject<Int, Never>()
    }
    
    class Output: ObservableObject {
        @Published var event: EventViewData = .init()
        @Published var dueration = 0
        @Published var eventPreviewHeight = 0
        @Published var eventPreviewPaddingTop = 0
        @Published var eventViewPadding = 0
        @Published var eventChange: EventViewData?
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        Just(event)
            .assign(to: \.event, on: output)
            .store(in: cancelBag)
        
        input.loadTrigger
            .map {
                event.end - event.start - 1
            }
            .assign(to: \.dueration, on: output)
            .store(in: cancelBag)
        
        output.$dueration
            .map {
                ($0 + 1) * Constant.hourUnit + $0
            }
            .assign(to: \.eventPreviewHeight, on: output)
            .store(in: cancelBag)
        
        output.$event
            .map {
                $0.start * Constant.hourUnit + $0.start
            }
            .assign(to: \.eventPreviewPaddingTop, on: output)
            .store(in: cancelBag)
        
        input.hourChange
            .compactMap { $0 }
            .map {
                event.start += $0
                event.end += $0
                return event
            }
            .assign(to: \.eventChange, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
