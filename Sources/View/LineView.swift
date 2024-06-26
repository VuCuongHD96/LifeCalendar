//
//  LineView.swift
//  
//
//  Created by Work on 26/6/24.
//

import SwiftUI

struct LineView: View {
    
    var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
            .foregroundColor(.blue)
            .frame(height: 1)
    }
}

#Preview {
    LineView()
}
