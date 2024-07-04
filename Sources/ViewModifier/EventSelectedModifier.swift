//
//  EventSelectedModifier.swift
//
//
//  Created by Work on 2/7/24.
//

import SwiftUI

struct EventSelectedModifier: ViewModifier {
    
    let event: EventViewData?
    
    func body(content: Content) -> some View {
        if let event = event {
            content.callBackEventSelected(event)
        } else {
            content
        }
    }
}
