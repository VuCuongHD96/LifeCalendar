//
//  DashArrayView.swift
//  
//
//  Created by Work on 24/6/24.
//

import SwiftUI

struct DashArrayView: View {
    
    private struct Constant {
        static let timeSpacing = CGFloat(TimeManager.hourSpacing)
    }
    
    var hourArray: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(hourArray, id: \.self) { _ in
                VStack(spacing: 0) {
                    LineView()
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 10, height: Constant.timeSpacing + 20)
                }
            }
            LineView()
        }
    }

}

#Preview {
    ScrollView {
        DashArrayView(hourArray: TimeManager.gethourArray())
    }
}
