//
//  CalendarInlineView.swift
//  LifeCalendar
//
//  Created by Work on 19/1/25.
//

import SwiftUI

struct CalendarInlineView: View {
    
    let input: CalendarInlineViewModel.Input = .init()
    @State var output: CalendarInlineViewModel.Output = .init()
    let viewModel = CalendarInlineViewModel()
    let cancelBag = CancelBag()
    private var gridItems = Array.init(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 0) {
            weekdaySymbolView
            weekDayListView
        }
        .onAppear {
            output = viewModel.transform(input, cancelBag: cancelBag)
        }
    }
    
    var weekdaySymbolView: some View {
        ForEach(output.weekdaySymbolList, id: \.self) { weekdaySymbol in
            Text(weekdaySymbol)
                .frame(maxWidth: .infinity, minHeight: 50)
        }
    }
    
    var weekDayListView: some View {
        ForEach(output.weekDayList, id: \.self) { weekday in
            Text("\(weekday.day)")
                .frame(maxWidth: .infinity, minHeight: 50)
        }
    }
}

#Preview {
    CalendarInlineView()
}
