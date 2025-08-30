import SwiftUI

struct CalendarView: View {
    
    let input: CalendarViewModel.Input
    @State private var output: CalendarViewModel.Output
    let cancelBag = CancelBag()
    
    init() {
        let viewModel = CalendarViewModel()
        let input = CalendarViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    var body: some View {
        Text("Calendar View")
            .font(.title)
            .navigationBarTitle("Life Calendar", displayMode: .inline)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
