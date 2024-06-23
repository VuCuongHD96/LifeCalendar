//
//  TimeView.swift
//
//
//  Created by Work on 23/6/24.
//

import SwiftUI

struct TimeView: View {
    
    private struct Constant {
        static let timeSpacing = CGFloat(TimeManager.hourSpacing)
    }
    
    var hourArray: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(hourArray, id: \.self) { hour in
                ZStack(alignment: .bottom) {
                    Text(hour)
                        .frame(height: 21)
                        .background(Color.green)
                        .padding(.bottom, Constant.timeSpacing)
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10, height: Constant.timeSpacing)
                }
            }
        }
    }
}

#Preview {
    return TimeView(hourArray: TimeManager.gethourArray())
}
