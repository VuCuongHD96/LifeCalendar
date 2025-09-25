//
//  EventDescriptionRow 2.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

import SwiftUI

struct EventDescriptionRow: View {
    
    let description: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "doc.plaintext")
                .resizable()
                .frame(width: 12, height: 12)
            Text(description)
        }
    }
}
