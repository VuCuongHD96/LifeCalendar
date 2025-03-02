//
//  EventSelectedModifier.swift
//
//
//  Created by Work on 2/7/24.
//

import SwiftUI

struct EventSelectedModifier: ViewModifier {
    
    let event: EventCellData
    
    func body(content: Content) -> some View {
        content.callBackEventSelected(event)
    }
}
