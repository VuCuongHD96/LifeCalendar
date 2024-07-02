//
//  File.swift
//  
//
//  Created by Work on 2/7/24.
//

import SwiftUI

extension LifeCalendar {
    
    typealias CallBackEvent = (EventViewData) -> Void
    
    func onEventSelected(callBackEvent: @escaping CallBackEvent) -> some View {
        onPreferenceChange(EventSelectedKey.self) { event in
            callBackEvent(event)
        }
    }
}
