//
//  EventManager.swift
//
//
//  Created by Work on 25/6/24.
//

import Foundation

struct EventManager {
    
    static func groupEvent(eventArray: [EventViewData]) -> [GroupEventViewData] {
        var groupedEvents = [GroupEventViewData]()
        
        for event in eventArray {
            var addedToGroup = false
            for index in 0..<groupedEvents.count {
                if groupedEvents[index].eventArray.contains(where: { t in
                    (event.start < t.end && event.end > t.start)
                }) {
                    groupedEvents[index].eventArray.append(event)
                    addedToGroup = true
                    break
                }
            }
            
            if !addedToGroup {
                let newGroupEvent = GroupEventViewData(eventArray: [event])
                groupedEvents.append(newGroupEvent)
            }
        }
        
        for index in 0..<groupedEvents.count {
            groupedEvents[index].scheduleTasks()
        }
        
        return groupedEvents
    }
}
