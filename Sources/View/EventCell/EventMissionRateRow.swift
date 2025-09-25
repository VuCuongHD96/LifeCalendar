//
//  EventMissionRateRow.swift
//  LifeCalendar
//
//  Created by sun on 26/9/25.
//

import SwiftUI

struct EventMissionRateRow: View {
    
    let data: EventMissionRowViewData
    
    var body: some View {
        HStack {
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
