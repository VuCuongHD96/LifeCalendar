//
//  LineView.swift
//
//
//  Created by Work on 26/6/24.
//

import SwiftUI

public struct LineView: View {
    
    let lineWidth: CGFloat
    let dashArray: [CGFloat]
    
    public init(
        lineWidth: CGFloat,
        dash: CGFloat?
    ) {
        self.lineWidth = lineWidth
        if let dash = dash {
            self.dashArray = [dash]
        } else {
            self.dashArray = [CGFloat]()
        }
    }
    
    public init(lineWidth: CGFloat) {
        self.init(lineWidth: lineWidth, dash: nil)
    }
    
    public init() {
        self.init(lineWidth: 1, dash: 1)
    }
    
    public var body: some View {
        Line()
            .stroke(style: StrokeStyle(lineWidth: lineWidth, dash: dashArray))
    }
}

//#Preview {
//    LineView(lineWidth: 1, dash: 1)
//    LineView(lineWidth: 5)
//}
