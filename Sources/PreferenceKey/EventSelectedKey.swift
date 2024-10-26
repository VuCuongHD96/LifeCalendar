//
//  EventSelectedKey.swift
//
//
//  Created by Work on 2/7/24.
//

import SwiftUI

struct EventSelectedKey: PreferenceKey {
    static var defaultValue: EventCellData = .init()

    static func reduce(value: inout EventCellData, nextValue: () -> EventCellData) {
        value = nextValue()
    }
}
