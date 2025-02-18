//
//  LifeDatePicker.swift
//  LifeCalendar
//
//  Created by Work on 18/2/25.
//

import SwiftUI

struct LifeDatePicker: View {
    
    @Binding var dateSelected: Date
    
    var body: some View {
        ZStack {
            DatePicker("", selection: $dateSelected, displayedComponents: .date)
                .frame(maxWidth: .infinity, alignment: .center)
                .labelsHidden()
                .opacity(0.1)
            Text(CalendarManager.createDateString(from: dateSelected, localeIdentifier: .vi))
                .fontWeight(.medium)
                .padding(8)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(.blue))
                .allowsHitTesting(false)
        }
    }
}

#Preview {
    LifeDatePicker(dateSelected: .constant(.now))
}
