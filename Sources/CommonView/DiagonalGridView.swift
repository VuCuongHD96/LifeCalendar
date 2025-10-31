//
//  DiagonalGridView.swift
//  ToDoLife
//
//  Created by sun on 31/10/25.
//

import SwiftUI

struct DiagonalGridView: View {
    
    let dividerSize = 0.5
    let dividerPadding = 1.0
    
    var body: some View {
        let numberOfHorizolDivider = Int(Screen.height / (dividerSize + dividerPadding))
        let numberOfVerticalDivider = Int(Screen.width / (dividerSize + dividerPadding))
        
        ZStack {
            VStack(spacing: 0) {
                ForEach(1...numberOfHorizolDivider, id: \.self) { _ in
                    dividerVerticalView
                }
            }
            HStack(spacing: 0) {
                ForEach(1...numberOfVerticalDivider, id: \.self) { _ in
                    dividerHorizontalView
                }
            }
        }
        .ignoresSafeArea()
    }
    
    private var dividerVerticalView: some View {
        Divider()
            .frame(height: dividerSize)
            .padding(.bottom, dividerPadding)
    }
    
    private var dividerHorizontalView: some View {
        Divider()
            .frame(width: dividerSize)
            .padding(.trailing, dividerPadding)
    }
}

#Preview {
    DiagonalGridView()
}
