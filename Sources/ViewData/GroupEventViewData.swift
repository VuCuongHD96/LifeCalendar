//
//  GroupEventViewData.swift
//  
//
//  Created by Work on 25/6/24.
//

import SwiftUI

struct GroupEventViewData: Identifiable, Sequence, Equatable {
    
    let id = UUID()
    var eventArray: [EventViewData]
    var matrixEventArray = [[EventViewData]]()
    
    func makeIterator() -> IndexingIterator<[EventViewData]> {
        return eventArray.makeIterator()
    }
    
    mutating func scheduleTasks() {
         let sortedEventList = eventArray.sorted { $0.start < $1.start }
         var schedule: [[EventViewData]] = []
         for event in sortedEventList {
             var placed = false
             for i in 0..<schedule.count {
                 if schedule[i].allSatisfy({ event.start >= $0.end || event.end <= $0.start }) {
                     schedule[i].append(event)
                     placed = true
                     break
                 }
             }
             if !placed {
                 schedule.append([event])
             }
         }
        
        for (index, row) in schedule.enumerated() {
            print("Column \(index + 1): \(row.map { $0.name })")
        }
        matrixEventArray = schedule
     }
}
