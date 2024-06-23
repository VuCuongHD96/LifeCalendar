//
//  DashView.swift
//  
//
//  Created by Work on 24/6/24.
//

import SwiftUI

struct DashView: View {
    
    private struct Constant {
        static let timeSpacing = CGFloat(TimeManager.hourSpacing)
    }
    
    var hourArray: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(hourArray, id: \.self) { _ in
                VStack(spacing: 0) {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                        .foregroundColor(.blue)
                        .frame(height: 1)
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10, height: Constant.timeSpacing + 20)
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        DashView(hourArray: TimeManager.gethourArray())
    }
}
