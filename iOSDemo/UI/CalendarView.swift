import SwiftUI
import LifeCalendar

struct CalendarView: View {
    
    let input: CalendarViewModel.Input
    @ObservedObject private var output: CalendarViewModel.Output
    let cancelBag = CancelBag()
    @State private var dateSelected: Date = .now
    
    init() {
        let viewModel = CalendarViewModel()
        let input = CalendarViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    var body: some View {
        VStack {
            CalendarInlineView(dateSelected: $dateSelected)
            LifeCalendar(
                groupedEvents: output.groupedEvents,
                eventChangedHandler: {
                    input.eventChangeTrigger.send($0)
                }
            )
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
