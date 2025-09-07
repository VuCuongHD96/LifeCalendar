//
//  GroupEventViewData.swift
//  
//
//  Created by Work on 25/6/24.
//

import SwiftUI

public struct GroupEventViewData: Identifiable, Sequence {
    
    public let id = UUID()
    var eventArray: [EventCellData]
    
    public func makeIterator() -> IndexingIterator<[EventCellData]> {
        return eventArray.makeIterator()
    }
}
