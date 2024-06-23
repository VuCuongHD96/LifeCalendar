// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct LifeCalendar: View {
    
    @State private var hourArray: [String] = []
    
    var body: some View {
        // 1. Time view
        ScrollView {
            timeView
        }
        // 2. Line View
        // 3. Task View
    }
    
    private var timeView: some View {
        TimeView(hourArray: hourArray)
            .onAppear {
                hourArray = TimeManager.gethourArray()
            }
    }
}

#Preview {
    LifeCalendar()
}
