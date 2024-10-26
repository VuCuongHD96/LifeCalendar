//
//  EventChangeModifier.swift
//  
//
//  Created by Work on 3/7/24.
//

import SwiftUI

struct EventChangeModifier: ViewModifier {
    
    @Binding var eventEndChanged: EventCellData?
    
    func body(content: Content) -> some View {
        
        if let event = eventEndChanged {
            content.callBackEventChanged(event)
        } else {
            content
        }
    }
}

