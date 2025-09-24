//
//  EventCell.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI

struct EventCell: View {
    
    let event: EventCellData
    let opacity: Double
    
    var body: some View {
        let eventStartHour = CGFloat(event.start.adjustToLocalTime().hour)
        let eventStartMinute = CGFloat(event.start.adjustToLocalTime().minute)
        let cellHeight: CGFloat = event.hourDueration * TimeManager.lineSpacing + (event.hourDueration - 1) - 1
        
        Rectangle()
            .fill(.clear)
            .setupLifeEventBackGroundModifier(
                param: .init(color: event.color, opacity: opacity)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                VStack {
                    Text(event.name)
                    Text("start = \(event.start.adjustToLocalTime().hour)")
                    Text("end   = \(event.end.adjustToLocalTime().hour)")
                }
            }
            .frame(height: cellHeight)
            .padding(.top, eventStartHour * TimeManager.lineSpacing + eventStartHour)
            .padding(.top, eventStartMinute)
            .padding(.top, TimeManager.lineHeight)
    }
}
