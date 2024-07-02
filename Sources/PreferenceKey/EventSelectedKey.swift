//
//  EventSelectedKey.swift
//
//
//  Created by Work on 2/7/24.
//

import SwiftUI

struct EventSelectedKey: PreferenceKey {
    static var defaultValue: EventViewData = .init()

    static func reduce(value: inout EventViewData, nextValue: () -> EventViewData) {
        value = nextValue()
    }
}
