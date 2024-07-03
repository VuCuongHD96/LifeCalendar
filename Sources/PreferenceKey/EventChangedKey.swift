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
