// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct LifeCalendar: View {
    
    @State private var hourArray: [String] = []
    @State private var groupedTasks: [GroupTaskViewData] = []
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                timeArrayView
                dashArrayView
                    .overlay(alignment: .top) {
                        taskArrayView
                    }
                    .padding(.top, 10)
            }
        }
        .onAppear {
            hourArray = TimeManager.gethourArray()
            groupedTasks = TaskManager.groupTask()
        }
    }
    
    private var timeArrayView: some View {
        TimeArrayView(hourArray: hourArray)
    }
    
    private var dashArrayView: some View {
        DashArrayView(hourArray: hourArray)
    }
    
    private var taskArrayView: some View {
        ZStack(alignment: .top) {
            ForEach(groupedTasks, id: \.id) { group in
                HStack(alignment: .top) {
                    ForEach(group.taskArray) { task in
                        TaskView(task: task)
                    }
                }
            }
        }
    }
}

#Preview {
    LifeCalendar()
}
