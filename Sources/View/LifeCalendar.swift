// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct LifeCalendar: View {
    
    @State private var hourArray: [String] = []
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                timeArrayView
                dashArrayView
                    .overlay {
                        TaskView()
                    }
            }
        }
        .onAppear {
            hourArray = TimeManager.gethourArray()
        }
    }
    
    private var timeArrayView: some View {
        TimeArrayView(hourArray: hourArray)
    }
    
    private var dashArrayView: some View {
        DashArrayView(hourArray: hourArray)
    }
}

#Preview {
    LifeCalendar()
}
