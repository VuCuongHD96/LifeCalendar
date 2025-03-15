//
//  CalendarDateRangeView.swift
//  LifeCalendar
//
//  Created by Work on 3/3/25.
//

import SwiftUI
import SwiftDate

public struct CalendarDateRangeView: View {
    
    // MARK: - Property
    @Environment(\.locale) var locale
    @Binding var startDate: Date
    @Binding var endDate: Date
    
    public init(startDate: Binding<Date>, endDate: Binding<Date>) {
        _startDate = startDate
        _endDate = endDate
    }

    public var body: some View {
        Section {
            DatePicker("Start date",
                       selection: $startDate,
                       displayedComponents: .date)
            DatePicker("End date",
                       selection: $endDate,
                       in: startDate.tomorrow...,
                       displayedComponents: .date)
        }
        .environment(\.locale, locale)
        .listRowInsets(EdgeInsets())
        .padding(.horizontal, 8)
    }
}

#Preview {
    
    @Previewable
    @State var startDate = Date.now
    
    @Previewable
    @State var endDate = Date.now.tomorrow
    
    CalendarDateRangeView(startDate: $startDate, endDate: $endDate)
}
