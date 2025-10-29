//
//  EventLocationRowViewData.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

public struct EventLocationRowViewData: Equatable {
    
    let name: String
    let address: String
    
    public init(name: String, address: String) {
        self.name = name
        self.address = address
    }
}
