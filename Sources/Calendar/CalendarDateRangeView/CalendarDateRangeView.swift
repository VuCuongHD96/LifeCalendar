//
//  CalendarDateRangeView.swift
//  LifeCalendar
//
//  Created by Work on 3/3/25.
//

import SwiftUI

public struct CalendarDateRangeView: View {
    
    @ObservedObject var input: CalendarDateRangeViewModel.Input = .init()
    @ObservedObject var output: CalendarDateRangeViewModel.Output = .init()
    let cancelBag = CancelBag()
    let viewModel = CalendarDateRangeViewModel()
    
    public init() {
        let input = CalendarDateRangeViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    public var body: some View {
        Section {
            DatePicker("Start date",
                       selection: $input.startDate,
                       displayedComponents: .date)
            DatePicker("End date",
                       selection: $input.endDate,
                       displayedComponents: .date)
        } footer: {
            if let durationDescription = output.durationDescription {
                Text(durationDescription)
                    .backgroundStyle(.red)
            }
        }
        .listRowInsets(EdgeInsets())
        .padding(.horizontal, 10)
    }
}

#Preview {
    CalendarDateRangeView()
}
