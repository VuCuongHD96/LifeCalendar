//
//  EventOffset.swift
//
//
//  Created by Work on 14/7/24.
//

import Foundation

struct EventOffset {
    var offset: CGFloat = .zero
    var lastOffset: CGFloat = .zero
    var totalOffset: CGFloat {
        offset + lastOffset
    }
    
    mutating func reset() {
        offset = 0
        lastOffset = 0
    }
}
