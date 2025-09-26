//
//  TimeListView.swift
//
//
//  Created by Work on 23/6/24.
//

import SwiftUI

struct TimeListView: View {
    
    private struct Constant {
        static let timeSpacing = CGFloat(TimeManager.timeLabelSpacing)
    }
    
    var hourArray: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(hourArray, id: \.self) { hour in
                ZStack(alignment: .bottom) {
                    timeView(hour: hour)
                        .padding(.bottom, Constant.timeSpacing)
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 10, height: Constant.timeSpacing)
                }
            }
            timeView(hour: "24:00")
        }
        .fixedSize()
    }
    
    private func timeView(hour: String) -> some View {
        Text(hour)
            .frame(height: TimeManager.timeLabelHeight)
            .background(
                Rectangle()
                    .fill(.blue.opacity(0.4))
            )
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 4,
                    topTrailingRadius: 4
                )
            )
    }
}

#Preview {
    ScrollView {
        TimeListView(hourArray: TimeManager.gethourArray())
    }
}
