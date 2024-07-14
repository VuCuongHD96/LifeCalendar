//
//  EventOffset.swift
//
//
//  Created by Work on 14/7/24.
//

import Foundation

struct EventOffset {
    var offset: Float = .zero
    var lastOffset: Float = .zero
    var totalOffset: Float {
        offset + lastOffset
    }
    
    mutating func reset() {
        offset = 0
        lastOffset = 0
    }
}
