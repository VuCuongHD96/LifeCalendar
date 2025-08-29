import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to LifeCalendar")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image(systemName: "calendar")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("Your life in weeks")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                NavigationLink(destination: CalendarView()) {
                    Text("View Calendar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

struct CalendarView: View {
    var body: some View {
        Text("Calendar View")
            .font(.title)
            .navigationBarTitle("Life Calendar", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
