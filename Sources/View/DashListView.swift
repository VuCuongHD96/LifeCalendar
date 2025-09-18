//
//  DashListView.swift
//
//
//  Created by Work on 24/6/24.
//

import SwiftUI

struct DashListView: View {
    
    private struct Constant {
        static let timeSpacing = CGFloat(TimeManager.timeLabelSpacing)
    }
    
    var hourArray: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(hourArray, id: \.self) { _ in
                VStack(spacing: 0) {
                    lineView
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10, height: TimeManager.lineSpacing)   
                }
            }
            lineView
        }
    }
    
    private var lineView: some View {
        LineView(lineWidth: 2, dash: 10)
            .foregroundStyle(.blue)
            .frame(height: 1)
    }
}

#Preview {
    ScrollView {
        DashListView(hourArray: TimeManager.gethourArray())
    }
}
