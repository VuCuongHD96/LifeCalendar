//
//  EventMissionRateRow.swift
//  LifeCalendar
//
//  Created by sun on 26/9/25.
//

import SwiftUI

public struct EventMissionRateRow: View {
    
    let data: EventMissionRowViewData
    
    public init(data: EventMissionRowViewData) {
        self.data = data
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            checkView
            Text(data.description)
        }
    }
    
    private var checkView: some View {
        Image(systemName: data.isFinished ? "checkmark.circle.fill" : "circle.dotted")
            .resizable()
            .frame(width: 12, height: 12)
    }
}

#Preview {
    
    EventMissionRateRow(data: .init(isFinished: true, description: "Description done"))
    EventMissionRateRow(data: .init(isFinished: false, description: "Description todo"))

}
