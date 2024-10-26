//
//  EventManager.swift
//
//
//  Created by Work on 25/6/24.
//

import Foundation

struct EventManager {
    
    static func groupEvent(eventArray: [EventCellData]) -> [GroupEventViewData] {
        var groupedEvents = [GroupEventViewData]()
        
        for event in eventArray {
            var addedToGroup = false
            for i in 0..<groupedEvents.count {
                if groupedEvents[i].eventArray.contains(where: { t in
                    (event.start < t.end && event.end > t.start)
                }) {
                    groupedEvents[i].eventArray.append(event)
                    addedToGroup = true
                    break
                }
            }
            if !addedToGroup {
                let newGroupEvent = GroupEventViewData(eventArray: [event])
                groupedEvents.append(newGroupEvent)
            }
        }
        return groupedEvents
    }
}
