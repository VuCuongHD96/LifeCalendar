//
//  EventChangedKey.swift
//
//
//  Created by Work on 3/7/24.
//

import SwiftUI

struct EventChangedKey: PreferenceKey {
    static var defaultValue: EventViewData = .init()

    static func reduce(value: inout EventViewData, nextValue: () -> EventViewData) {
        value = nextValue()
    }
}

struct HourChangedKey: PreferenceKey {
    static var defaultValue: Int = 0

    static func reduce(value: inout Int, nextValue: () -> Int) {
        value = nextValue()
    }
}
