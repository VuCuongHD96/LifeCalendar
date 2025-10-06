//
//  EventDescriptionRow 2.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

import SwiftUI

public struct EventDescriptionRow: View {
    
    let description: String
    
    public init(description: String) {
        self.description = description
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "doc.plaintext")
                .resizable()
                .frame(width: 12, height: 12)
            Text(description)
        }
    }
}

#Preview {
    
    EventDescriptionRow(description: "Event description")
}
