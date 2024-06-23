// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct LifeCalendar: View {
    
    @State private var hourArray: [String] = []
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                timeView
                dashView
                    .padding(.top, 10)
            }
        }
        .onAppear {
            hourArray = TimeManager.gethourArray()
        }
    }
    
    private var timeView: some View {
        TimeView(hourArray: hourArray)
    }
    
    private var dashView: some View {
        DashView(hourArray: hourArray)
    }
}

#Preview {
    LifeCalendar()
}
