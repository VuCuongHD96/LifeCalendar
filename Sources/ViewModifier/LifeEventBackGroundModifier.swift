//
//  LifeEventBackGroundModifier.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

import SwiftUI

public struct LifeEventBackGroundModifier: ViewModifier {
    
    let param: Param
    
    @State private var progress: CGFloat = 0
    
    public init(param: Param) {
        self.param = param
    }
    
    public func body(content: Content) -> some View {
        content
            .background(
                backGroundView
            )
    }
    
    private var backGroundView: some View {
        GeometryReader { geo in
            HStack(alignment: .bottom, spacing: 0) {
                Rectangle()
                    .fill(
                        param.color.opacity(param.opacity)
                    )
                    .overlay(alignment: .bottom) {
                        param.color.opacity(1)
                            .frame(height: geo.size.height * progress)
                    }
                    .frame(maxWidth: 5, maxHeight: .infinity, alignment: .bottom)

                Rectangle()
                    .fill(
                        param.color.opacity(param.opacity)
                    )
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .leading)
        }
        .onAppear {
            progress = CGFloat(param.progress)
        }
        .animation(
            .spring(duration: 2),
            value: progress
        )
    }
}

extension View {
    
    public func setupLifeEventBackGroundModifier(
        param: LifeEventBackGroundModifier.Param
    ) -> some View {
        self.modifier(
            LifeEventBackGroundModifier(param: param)
        )
    }
}
