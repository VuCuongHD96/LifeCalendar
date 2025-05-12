//
//  LifeDatePicker.swift
//  LifeCalendar
//
//  Created by Work on 18/2/25.
//

import SwiftUI

struct LifeDatePicker: View {
    
    @Binding var dateSelected: Date
    @Environment(\.locale) var locale
    @State private var isDatePickerShown = false
    
    var body: some View {
        Text(CalendarManager.createDateString(from: dateSelected, locale: locale))
            .fontWeight(.medium)
            .padding(8)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous).foregroundColor(.blue))
            .onTapGesture {
                isDatePickerShown.toggle()
            }
            .popover(isPresented: $isDatePickerShown) {
                DatePicker("", selection: $dateSelected, displayedComponents: .date)
                    .labelsHidden()
                    .environment(\.locale, locale)
                    .datePickerStyle(.graphical)
                    .presentationCompactAdaptation(.popover)
                    .frame(width: 300, height: 310)
            }
    }
}

#Preview {
    LifeDatePicker(dateSelected: .constant(.now))
}
