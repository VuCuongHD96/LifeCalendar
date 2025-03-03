//
//  CalendarDateRangeView.swift
//  LifeCalendar
//
//  Created by Work on 3/3/25.
//

import SwiftUI

public struct CalendarDateRangeView: View {
    
    @State var startDate = Date()
    @State var endDate = Date()
    @State var duration: TimeInterval = .zero
    @State var durationString: String?
    
    public init() { }
    
    public var body: some View {
        Section {
            DatePicker("Start date",
                       selection: $startDate,
                       displayedComponents: .date)
            DatePicker("End date",
                       selection: $endDate,
                       displayedComponents: .date)
        } footer: {
            if let durationString = durationString {
                Text(durationString)
            }
        }
        .listRowInsets(EdgeInsets())
        .padding(.horizontal, 10)
        .onChange(of: startDate, setupLogic)
        .onChange(of: endDate, setupLogic)
    }
    
    func setupLogic() {
        setupDuration()
        setupDurationDescription()
    }
    
    func setupDuration() {
        duration = endDate.timeIntervalSince(startDate)
    }
    
    func setupDurationDescription() {
        durationString = DurationManager.getDurationString(from: duration)
    }
}

#Preview {
    CalendarDateRangeView()
}
