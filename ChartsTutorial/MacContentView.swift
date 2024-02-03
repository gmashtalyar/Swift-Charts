import SwiftUI

struct MacContentView: View {
    
    enum NavigationSelection {
        case recentSales
        case salesPerWeekday
        case salesPerCategory
        case expenses
    }
    
    @StateObject var salesViewModel: SalesViewModel = .preview
    @StateObject var expensesViewModel: ExpensesViewModel = .preview
    
    @State private var navigationSelection: NavigationSelection? = .recentSales
    
    var body: some View {
        NavigationSplitView {
            List(selection: $navigationSelection) {
                NavigationLink(destination: DetailBookSalesView(salesViewModel: salesViewModel), tag: .recentSales, selection: $navigationSelection) {
                    SimpleBookSalesView(salesViewModel: salesViewModel)
                }
                NavigationLink(destination: SalesByWeekDayView(salesViewModel: salesViewModel), tag: .salesPerWeekday, selection: $navigationSelection) {
                    SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
                }
                NavigationLink(destination: SalesPerBookCategoryView(salesViewModel: salesViewModel), tag: .salesPerCategory, selection: $navigationSelection) {
                    SimpleSalesPerBookCategoryView(salesViewModel: salesViewModel)
                }
                NavigationLink(destination: DetailExpensesView(expensesViewModel: expensesViewModel), tag: .expenses, selection: $navigationSelection) {
                    SimpleExpensesLineChartView(expensesViewModel: expensesViewModel)
                }
            }
            .listRowInsets(.init(top: 10, leading: 10, bottom: 50, trailing: 10))
        } detail: {
            switch navigationSelection {
                case .recentSales:
                    DetailBookSalesView(salesViewModel: salesViewModel)
                case .salesPerWeekday:
                    SalesByWeekDayView(salesViewModel: salesViewModel)
                case .salesPerCategory:
                    SalesPerBookCategoryView(salesViewModel: salesViewModel)
                case .expenses:
                    DetailExpensesView(expensesViewModel: expensesViewModel)
                default:
                    Text("Placeholder")
            }
        }
    }
}


//#Preview {
//    MacContentView()
//}
