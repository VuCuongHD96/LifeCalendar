//
//  TimeListView.swift
//
//
//  Created by Work on 23/6/24.
//

import SwiftUI

struct TimeListView: View {
    
    private struct Constant {
        static let timeSpacing = CGFloat(TimeManager.hourSpacing)
    }
    
    var hourArray: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(hourArray, id: \.self) { hour in
                ZStack(alignment: .bottom) {
                    timeView(hour: hour)
                        .padding(.bottom, Constant.timeSpacing)
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10, height: Constant.timeSpacing)
                }
            }
            timeView(hour: "12:00 PM")
        }
    }
    
    private func timeView(hour: String) -> some View {
        Text(hour)
            .frame(height: 21)
            .background(Color.green)
    }
}

#Preview {
    ScrollView {
        TimeListView(hourArray: TimeManager.gethourArray())
    }
}
