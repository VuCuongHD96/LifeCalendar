//
//  EventCellModifier.swift
//  LifeCalendar
//
//  Created by sun on 30/9/25.
//

import SwiftUI

struct EventCellModifier: ViewModifier {
    
    struct Param {
        let event: EventCellData
        let dateSelected: Date
        let opacity: Double
    }
    
    let param: Param
    
    func body(content: Content) -> some View {
        let eventStart = param.event.start
        let startOfSelectedDate = param.dateSelected.dateAtStartOf(.day)
        let startDateRemake = eventStart < startOfSelectedDate ? startOfSelectedDate : eventStart
        let eventStartHour = CGFloat(startDateRemake.hour)
        let eventStartMinute = CGFloat(startDateRemake.minute)
        
        content
            .setupLifeEventBackGroundModifier(
                param: .init(color: param.event.color, opacity: param.opacity)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 8)
            )
            .padding(.top, eventStartHour * TimeManager.lineSpacing + eventStartHour)
            .padding(.top, eventStartMinute)
            .padding(.top, TimeManager.lineHeight)
    }
}

extension View {

    func setupEventCellModifier(param: EventCellModifier.Param) -> some View {
        modifier(
            EventCellModifier(param: param)
        )
    }
}
