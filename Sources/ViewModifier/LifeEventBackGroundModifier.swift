//
//  LifeEventBackGroundModifier.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

import SwiftUI

public struct LifeEventBackGroundModifier: ViewModifier {
    
    let param: Param
    
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
        HStack(spacing: 0) {
            Rectangle()
                .fill(
                    param.color.opacity(1)
                )
                .frame(maxWidth: 5, maxHeight: .infinity)
            Rectangle()
                .fill(
                    param.color.opacity(param.opacity)
                )
        }
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
