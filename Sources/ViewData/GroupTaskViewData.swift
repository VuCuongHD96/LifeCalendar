//
//  GroupTaskViewData.swift
//  
//
//  Created by Work on 25/6/24.
//

import SwiftUI

struct GroupTaskViewData: Identifiable, Sequence {
    
    let id = UUID()
    var taskArray: [TaskViewData]
    
    func makeIterator() -> IndexingIterator<[TaskViewData]> {
        return taskArray.makeIterator()
    }
}
