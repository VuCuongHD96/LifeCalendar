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
    private var cancelBag = CancelBag()
    private var gridItems = Array.init(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    @State private var weekDayList: [Date] = []
    @State private var weekdaySymbolList = [String]()
    @State private var dateSelectedString = ""
    
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
                .padding(.horizontal, 4)
                .fontWeight(.bold)
        }
        .onAppear {
            dateSelected = .now
        }
        .onChange(of: dateSelected) { oldValue, newValue in
            weekDayList = CalendarManager.getWeekDateList(from: newValue)
            dateSelectedString = CalendarManager.createDateString(from: newValue, localeIdentifier: .vi)
            weekdaySymbolList = CalendarManager.weekdaySymbolsStarting(from: .monday, localeIdentifier: .vi)
        }
    }
    
    var dateInfo: some View {
        HStack {
            Image(systemName: "arrow.backward")
                .frame(width: 40, height: 40)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    dateSelected = CalendarManager.getForwarkWeekDate(from: dateSelected)
                }
            Text(dateSelectedString)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
            Image(systemName: "arrow.forward")
                .frame(width: 40, height: 40)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    dateSelected = CalendarManager.getNextWeekDate(from: dateSelected)
                }
        }
    }
    
    var weekdaySymbolView: some View {
        ForEach(weekdaySymbolList, id: \.self) { weekdaySymbol in
            Text(weekdaySymbol)
                .frame(maxWidth: .infinity, minHeight: 50)
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
