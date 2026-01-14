//
//  CalendarDateRangeView.swift
//  LifeCalendar
//
//  Created by Work on 3/3/25.
//

import SwiftUI
import SwiftDate

public struct CalendarDateRangeView: View {
    
    // MARK: - Define
   public typealias DateHander = (DateInterval) -> Void
    
    // MARK: - Property
    @Environment(\.locale) var locale
    @State private var startDate: Date = Date.now
    @State private var endDate: Date = Date.now + 1.days
    let dateIntervalHandler: DateHander

    public init(dateIntervalHandler: @escaping DateHander) {
        self.dateIntervalHandler = dateIntervalHandler
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
        .onChange(of: startDate) { oldValue, newValue in
            handlerDateInterval(startDate: newValue, endDate: endDate)
        }
        .onChange(of: endDate) { oldValue, newValue in
            handlerDateInterval(startDate: startDate, endDate: newValue)
        }
        .onAppear {
            handlerDateInterval(startDate: startDate, endDate: endDate)
        }
    }
    
    private func handlerDateInterval(startDate: Date, endDate: Date) {
        if startDate < endDate {
            let dateInterval = DateInterval(start: startDate, end: endDate)
            dateIntervalHandler(dateInterval)
        } else {
            self.endDate = startDate + 1.days
        }
    }
}

#Preview {
    
    CalendarDateRangeView(dateIntervalHandler: {
        print("--- date interval = ", $0)
    })
}
