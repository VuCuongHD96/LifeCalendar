//
//  EventLocationRow.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

import SwiftUI

struct EventLocationRow: View {
    
    let eventLocationViewData: EventLocationRowViewData
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "mappin.and.ellipse.circle")
                .resizable()
                .frame(width: 12, height: 12)
            addressText
        }
    }
    
    private var addressText: some View {
        return Text(eventLocationViewData.name)
            .foregroundStyle(Color(.label))
            .fontWeight(.medium)
        + Text(" - ")
        + Text(eventLocationViewData.address)
    }
}

#Preview {
    EventLocationRow(eventLocationViewData: .init(name: "My HN", address: "Ha Noi, Viet Nam"))
}
