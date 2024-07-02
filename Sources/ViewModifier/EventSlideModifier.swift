//
//  EventSlideModifier.swift
//  
//
//  Created by Work on 3/7/24.
//

import SwiftUI

struct EventSlideModifier: ViewModifier {
    
    var eventEndSliding: EventViewData?
    
    func body(content: Content) -> some View {
        
        if let event = eventEndSliding {
            content.callBackEventChanged(event)
        } else {
            content
        }
    }
}

