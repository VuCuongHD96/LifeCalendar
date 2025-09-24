//
//  LifeEventBackGroundModifier+param.swift
//  LifeCalendar
//
//  Created by sun on 25/9/25.
//

import SwiftUICore

extension LifeEventBackGroundModifier {
    
    public struct Param {
        
        let color: Color
        let opacity: Double
        
        public init(color: Color, opacity: Double) {
            self.color = color
            self.opacity = opacity
        }
    }
}
