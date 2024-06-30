// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct LifeCalendar: View {
    
    @State private var hourArray: [String] = []
    @State private var groupedTasks: [GroupTaskViewData] = []
    
    let taskArray: [TaskViewData]
    
    public init(taskArray: [TaskViewData]) {
        self.taskArray = taskArray
    }

    public var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                TimeArrayView(hourArray: hourArray)
                DashArrayView(hourArray: hourArray)
                    .overlay(alignment: .top) {
                        taskArrayView
                    }
                    .padding(.top, 10)
            }
        }
        .onAppear {
            hourArray = TimeManager.gethourArray()
            groupedTasks = TaskManager.groupTask(taskArray: taskArray)
        }
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
    
    let task1 = TaskViewData(name: "task1", start: 17, end: 20)
    let task2 = TaskViewData(name: "task2", start: 19, end: 23)
    let task3 = TaskViewData(name: "task3", start: 1, end: 2)
    let task4 = TaskViewData(name: "task4", start: 2, end: 3)
    let taskArray = [task1, task2, task3, task4]
    
    return LifeCalendar(taskArray: taskArray)
}
