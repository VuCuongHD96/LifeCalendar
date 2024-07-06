//
//  EventChangeModifier.swift
//
//
//  Created by Work on 3/7/24.
//

import SwiftUI

struct EventChangeModifier: ViewModifier {
    
    let eventEndChanged: EventViewData?
    
    func body(content: Content) -> some View {
//        print("\n\n\n--- debug --- EventChangeModifier = ")
//        print("--- debug --- event name = ", eventEndChanged?.name)
//        print("--- debug --- event start = ", eventEndChanged?.start)
//        print("--- debug --- event end = ", eventEndChanged?.end)
        if let event = eventEndChanged {
            return AnyView(content.callBackEventChanged(event))
        } else {
            return AnyView(content)
        }
//        return conte
    }
}
