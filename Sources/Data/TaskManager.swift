//
//  TaskManager.swift
//
//
//  Created by Work on 25/6/24.
//

import Foundation

struct TaskManager {
    
    static func groupTask(taskArray: [TaskViewData]) -> [GroupTaskViewData] {
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
        return groupedTasks
    }
}
