//
//  EventCell.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI

struct EventCell: View {

    var event: EventCellData
    var opacity: Double? = 0.5
 
    var body: some View {
        let eventStartHour = CGFloat(event.start.adjustToLocalTime().hour)

        Rectangle()
            .fill(Color.blue.opacity(opacity ?? 1))
            .overlay {
                VStack {
                    Text(event.name)
                    Text("start = \(event.start.adjustToLocalTime().hour)")
                    Text("end   = \(event.end.adjustToLocalTime().hour)")
                }
            }
            .frame(height: CGFloat(event.dueration) * Constant.hourHeight + CGFloat(event.dueration - 1))
            .padding(.top, eventStartHour * Constant.hourHeight + eventStartHour)
    }

}
