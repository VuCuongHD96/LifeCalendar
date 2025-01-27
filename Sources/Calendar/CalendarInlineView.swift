//
//  CalendarInlineView.swift
//  LifeCalendar
//
//  Created by Work on 19/1/25.
//

import SwiftUI
import SwiftDate

struct CalendarInlineView: View {
    
    // MARK: Define
    typealias DateHandler = (Date) -> Void
    
    // MARK: Property
    var dateSelected: DateHandler?
    @ObservedObject var input: CalendarInlineViewModel.Input = .init()
    @State var output: CalendarInlineViewModel.Output = .init()
    private let viewModel = CalendarInlineViewModel()
    private let cancelBag = CancelBag()
    private var gridItems = Array.init(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: gridItems, spacing: 0) {
                weekdaySymbolView
                weekDayListView
            }
            Text(output.dateSelectedString)
                .fontWeight(.medium)
        }
        .onAppear {
            output = viewModel.transform(input, cancelBag: cancelBag)
        }
    }
    
    var weekdaySymbolView: some View {
        ForEach(output.weekdaySymbolList, id: \.self) { weekdaySymbol in
            Text(weekdaySymbol)
                .frame(maxWidth: .infinity, minHeight: 50)
                .fontWeight(.bold)
        }
    }
    
    var weekDayListView: some View {
        ForEach(output.weekDayList, id: \.self) { weekday in
            Text("\(weekday.day)")
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(
                    input.dateSelected.day == weekday.day ? .red : .clear
                )
                .clipShape(Circle())
                .foregroundStyle(
                    input.dateSelected.day == weekday.day ? .white : .black
                )
                .onTapGesture {
                    input.dateSelected = weekday
                    dateSelected?(weekday)
                }
        }
    }
}

#Preview {
    CalendarInlineView()
}
