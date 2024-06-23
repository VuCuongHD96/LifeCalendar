//
//  Line.swift
//
//
//  Created by Work on 24/6/24.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    Line()
        .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
        .foregroundColor(.blue)
}
