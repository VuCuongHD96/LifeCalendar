//
//  LineView.swift
//  
//
//  Created by Work on 26/6/24.
//

import SwiftUI

public struct LineView: View {
    
    public init() { }
    
    public var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
            .foregroundColor(.blue)
            .frame(height: 1)
    }
}

#Preview {
    LineView()
}
