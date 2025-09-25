//
//  EventCellInfo.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

import SwiftUI

struct EventCellInfo: View {
    let event: EventCellData
    
    var body: some View {
        ViewThatFits(in: .vertical) {
            ForEach(0..<4) { level in
                VStack(alignment: .leading, spacing: 0) {
                    if level <= 3 {
                        EventNameRow(name: event.name)
                    }
                    
                    if let missionRateData = event.missionRateData, level <= 2 {
                        EventMissionRateRow(data: missionRateData)
                    }
                    
                    if level <= 1, !event.description.isEmpty {
                        EventDescriptionRow(description: event.description)
                            .lineLimit(1)
                    }
                    
                    if let locationInfo = event.locationInfo, level <= 0  {
                        EventLocationRow(eventLocationViewData: locationInfo)
                            .lineLimit(1)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 8)
    }
}
