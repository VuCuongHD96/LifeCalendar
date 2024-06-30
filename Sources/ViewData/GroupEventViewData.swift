//
//  GroupEventViewData.swift
//  
//
//  Created by Work on 25/6/24.
//

import SwiftUI

struct GroupEventViewData: Identifiable, Sequence {
    
    let id = UUID()
    var eventArray: [EventViewData]
    
    func makeIterator() -> IndexingIterator<[EventViewData]> {
        return eventArray.makeIterator()
    }
}
