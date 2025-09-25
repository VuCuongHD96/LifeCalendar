//
//  EventNameRow.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

import SwiftUI

struct EventNameRow: View {
    
    let name: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "text.alignleft")
                .resizable()
                .frame(width: 12, height: 12)
            Text(name)
        }
    }
}

#Preview {
    EventNameRow(name: "Event name")
}
