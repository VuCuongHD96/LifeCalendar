//
//  GroupEventViewData.swift
//  
//
//  Created by Work on 25/6/24.
//

import SwiftUI

struct GroupEventViewData: Identifiable, Sequence {
    
    let id = UUID()
    var eventArray: [EventCellData]
    
    func makeIterator() -> IndexingIterator<[EventCellData]> {
        return eventArray.makeIterator()
    }
}
