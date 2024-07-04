//
//  File.swift
//  
//
//  Created by Work on 2/7/24.
//

import SwiftUI

extension View {
    func callBackEventSelected(_ event: EventViewData) -> some View {
        preference(key: EventSelectedKey.self, value: event)
    }
    
    func callBackEventChanged(_ event: EventViewData) -> some View {
        preference(key: EventChangedKey.self, value: event)
    }
}
