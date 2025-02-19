//
//  WeekNavigateModifier.swift
//  LifeCalendar
//
//  Created by Work on 18/2/25.
//

import SwiftUI

struct WeekNavigateModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(width: 30, height: 30)
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
