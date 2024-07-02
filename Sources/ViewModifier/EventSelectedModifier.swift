//
//  EventSelectedModifier.swift
//
//
//  Created by Work on 2/7/24.
//

import SwiftUI

struct EventSelectedModifier: ViewModifier {
    
    let selected: Bool
    let event: EventViewData

    func body(content: Content) -> some View {
        if selected {
            content.callBackEvent(event)
        } else {
            content
        }
    }
}
