//
//  LifeCalendar+.swift
//
//
//  Created by Work on 2/7/24.
//

import SwiftUI

extension View {
    
    public typealias CallBackEvent = (EventViewData) -> Void
    
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
    
    public func onEventChanged2(callHour: @escaping (Int) -> Void) -> some View {
        onPreferenceChange(EventChangedKey2.self) { hour in
            callHour(hour)
        }
    }
}
