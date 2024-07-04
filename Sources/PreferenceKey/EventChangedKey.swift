//
//  EventChangedKey.swift
//
//
//  Created by Work on 3/7/24.
//

import SwiftUI

struct EventChangedKey: PreferenceKey {
    static var defaultValue: EventViewData? = nil

    static func reduce(value: inout EventViewData?, nextValue: () -> EventViewData?) {
        print("--- debug --- EventChangedKey --- value --- event = ", value?.name ?? "nil")
        value = nextValue()
    }
}
