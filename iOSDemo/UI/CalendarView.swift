import SwiftUI
import LifeCalendar

struct CalendarView: View {
    
    @ObservedObject private var input: CalendarViewModel.Input
    @ObservedObject private var output: CalendarViewModel.Output
    let cancelBag = CancelBag()
    
    init() {
        let viewModel = CalendarViewModel()
        let input = CalendarViewModel.Input()
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
    
    var body: some View {
        VStack {
            CalendarInlineView(dateSelected: $input.dateSelected)
            LifeCalendar(
                dateSelected: input.dateSelected,
                eventSelected: $input.eventSelected,
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
