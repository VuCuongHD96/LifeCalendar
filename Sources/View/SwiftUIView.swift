//
//  TaskView.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI

struct TaskView: View {
    
    var body: some View {
        Rectangle()
            .fill(Color.blue.opacity(0.5))
            .overlay {
                VStack {
                    Text("Task name")
                    Text("start = \(1)")
                    Text("end   = \(3)")
                }
            }
            .frame(height: 200)
    }
}

#Preview {
    TaskView()
}
