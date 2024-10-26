//
//  EventChangedKey.swift
//
//
//  Created by Work on 3/7/24.
//

import SwiftUI

struct EventChangedKey: PreferenceKey {
    static var defaultValue: EventCellData = .init()

    static func reduce(value: inout EventCellData, nextValue: () -> EventCellData) {
        value = nextValue()
    }
}
