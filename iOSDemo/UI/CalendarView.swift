import SwiftUI
import LifeCalendar

struct CalendarView: View {
    
    let input: CalendarViewModel.Input
    @ObservedObject private var output: CalendarViewModel.Output
    let cancelBag = CancelBag()
    
    init() {
        let viewModel = CalendarViewModel()
        let input = CalendarViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    var body: some View {
        LifeCalendar(
            eventArray: output.eventList,
            eventChangedHandler: { _ in

            }
        )
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
