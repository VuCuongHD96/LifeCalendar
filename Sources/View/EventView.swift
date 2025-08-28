//
//  EventView.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI

struct EventView: View {

    var event: EventCellData
 
    var body: some View {
        Rectangle()
            .fill(event.selected ? Color.blue : Color.blue.opacity(0.5))
            .overlay {
                VStack {
                    Text(event.name)
                    Text("start = \(event.start.adjustToLocalTime().hour)")
                    Text("end   = \(event.end.adjustToLocalTime().hour)")
                }
            }
    }

}

#Preview {

    let event = EventCellData(id: "1", name: "Event 1", start: .setTime(hour: 1), end: .setTime(hour: 3))
    return ScrollView {
        EventView(event: event)
    }
    .background(Color.green)
}
