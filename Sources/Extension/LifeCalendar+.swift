//
//  LifeCalendar+.swift
//
//
//  Created by Work on 2/7/24.
//

import SwiftUI

extension View {
    
    public typealias CallBackEvent = (EventViewData?) -> Void
    
    public func onEventSelected(callBackEvent: @escaping CallBackEvent) -> some View {
        onPreferenceChange(EventSelectedKey.self) { event in
            callBackEvent(event)
        }
    }
    
    public func onEventChanged(callBackEvent: @escaping CallBackEvent) -> some View {
        onPreferenceChange(EventChangedKey.self) { event in
            callBackEvent(event)
        }
    }
}
