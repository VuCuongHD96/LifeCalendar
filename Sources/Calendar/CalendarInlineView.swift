//
//  CalendarInlineView.swift
//  LifeCalendar
//
//  Created by Work on 19/1/25.
//

import SwiftUI
import SwiftDate

public struct CalendarInlineView: View {
    
    @Binding var dateSelected: Date
    var gridItems = Array.init(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    @State var weekDayList: [Date] = []
    @State var weekdaySymbolList = [String]()
    
    public init(dateSelected: Binding<Date>) {
        _dateSelected = dateSelected
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            LazyVGrid(columns: gridItems, spacing: 0) {
                weekdaySymbolView
                weekDayListView
            }
            dateInfo
                .fontWeight(.medium)
                .padding(.horizontal, 8)
        }
        .onAppear {
            dateSelected = .now
        }
        .onChange(of: dateSelected) { oldValue, newValue in
            weekDayList = CalendarManager.getWeekDateList(from: newValue)
            weekdaySymbolList = CalendarManager.weekdaySymbolsStarting(from: .monday, localeIdentifier: .vi)
        }
    }
    
    var dateInfo: some View {
        HStack {
            Image(systemName: "arrow.backward")
                .modifier(WeekNavigateModifier())
                .onTapGesture {
                    dateSelected = CalendarManager.getForwarkWeekDate(from: dateSelected)
                }
            LifeDatePicker(dateSelected: $dateSelected)
                .frame(maxWidth: .infinity)
            Image(systemName: "arrow.forward")
                .modifier(WeekNavigateModifier())
                .onTapGesture {
                    dateSelected = CalendarManager.getNextWeekDate(from: dateSelected)
                }
        }
    }
    
    var weekdaySymbolView: some View {
        ForEach(weekdaySymbolList, id: \.self) { weekdaySymbol in
            Text(weekdaySymbol)
                .frame(maxWidth: .infinity, minHeight: 30)
                .fontWeight(.bold)
        }
    }
    
    var weekDayListView: some View {
        ForEach(weekDayList, id: \.self) { weekday in
            Text("\(weekday.day)")
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(
                    dateSelected.day == weekday.day ? .red : .clear
                )
                .clipShape(Circle())
                .foregroundStyle(
                    dateSelected.day == weekday.day ? .white : Color.primary
                )
                .onTapGesture {
                    dateSelected = weekday
                }
        }
    }
}

#Preview {
    
    @Previewable
    @State var dateSelected: Date = .now
    
    CalendarInlineView(dateSelected: $dateSelected)
}
