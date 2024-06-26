//
//  TaskManager.swift
//
//
//  Created by Work on 25/6/24.
//

import Foundation

struct TaskManager {
    
    static private let task1 = TaskViewData(name: "task1", start: 17, end: 20)
    static private let task2 = TaskViewData(name: "task2", start: 19, end: 23)
    static private let task3 = TaskViewData(name: "task3", start: 1, end: 2)
    static private let task4 = TaskViewData(name: "task4", start: 2, end: 3)
    static private var taskArray = [task1, task2, task3, task4]
    

    static func groupTask() -> [GroupTaskViewData] {
        var groupedTasks = [GroupTaskViewData]()
        
        for task in taskArray {
            var addedToGroup = false
            for i in 0..<groupedTasks.count {
                if groupedTasks[i].taskArray.contains(where: { t in
                    (task.start < t.end && task.end > t.start)
                }) {
                    groupedTasks[i].taskArray.append(task)
                    addedToGroup = true
                    break
                }
            }
            if !addedToGroup {
                let newGroupTask = GroupTaskViewData(taskArray: [task])
                groupedTasks.append(newGroupTask)
            }
        }
        
        for (index, group) in groupedTasks.enumerated() {
            var groupTask = GroupTaskViewData(taskArray: [])
            for task in group {
                groupTask.taskArray.append(task)
            }
        }
        return groupedTasks
    }

}
