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
            Rectangle()
                .fill(
                    param.color.opacity(param.opacity)
                )
                .overlay(alignment: .bottomLeading) {
                    ZStack(alignment: .bottomLeading) {
                        Rectangle()
                            .mask(
                                DiagonalGridView()
                                    .rotationEffect(.degrees(-45))
                            )
                            .frame(width: 5, height: geo.size.height)
                        Rectangle()
                            .fill(
                                param.color.opacity(1)
                            )
                            .frame(width: 5, height: geo.size.height * progress)
                    }
                }
        }
        .onAppear {
            progress = CGFloat(param.progress)
        }
        .onChange(of: param.progress) { oldValue, newValue in
            progress = CGFloat(newValue)
        }
        .animation(
            .smooth(duration: 2),
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
