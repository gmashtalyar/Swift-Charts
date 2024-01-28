import SwiftUI
import Charts

struct WeeklyChartsView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        Chart(salesViewModel.salesByWeek, id: \.day) { saleDate in
            BarMark(x: .value("Week", saleDate.day, unit: .weekOfYear),
                    y: .value("Sales", saleDate.sales))
            .foregroundStyle(Color.blue.gradient)
        }
    }
}


struct PlainDataWeeklyChartsView: View {
    
    let salesData: [Sale]
    
    var body: some View {
        Chart(salesData) { sale in
            BarMark(x: .value("Week", sale.saleDate, unit: .weekOfYear),
                    y: .value("Sales", sale.quantity))
            .foregroundStyle(Color.blue.gradient)
        }
    }
}


#Preview {
    WeeklyChartsView(salesViewModel: SalesViewModel.preview)
        .aspectRatio(1, contentMode: .fit)
        .padding()
}

#Preview("Plain") {
    PlainDataWeeklyChartsView(salesData: Sale.threeMonthsExamples())
        .aspectRatio(1, contentMode: .fit)
        .padding()
}
