//
//  TaskView.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI

struct TaskView: View {
    
    let task: EventViewData
    
    var body: some View {
        let dueration = task.end - task.start - 1
        Rectangle()
            .fill(Color.blue.opacity(0.5))
            .overlay {
                VStack {
                    Text(task.name)
                    Text("start = \(task.start)")
                    Text("end   = \(task.end)")
                }
            }
            .frame(height: CGFloat(dueration + 1) * 80 + CGFloat(dueration))
            .padding(.top, Double(task.start) * 80 + Double(task.start))
    }
}

#Preview {
    let task = EventViewData(name: "Task 1", start: 1, end: 3)
    return TaskView(task: task)
}
