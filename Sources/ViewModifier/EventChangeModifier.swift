//
//  EventChangeModifier.swift
//
//
//  Created by Work on 3/7/24.
//

import SwiftUI

struct EventChangeModifier: ViewModifier {
    
    let eventEndChanged: EventViewData
    
    func body(content: Content) -> some View {
        content.callBackEventChanged(eventEndChanged)
    }
}

struct HourChangeModifier: ViewModifier {
    
    var hour: Int
    
    func body(content: Content) -> some View {
        content.callBackHourChanged(hour)
    }
}
