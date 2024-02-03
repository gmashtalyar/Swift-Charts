import SwiftUI

struct ContentView: View {
    
    @StateObject var salesViewModel = SalesViewModel.preview
    @StateObject var expensesViewModel = ExpensesViewModel.preview
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        DetailBookSalesView(salesViewModel: salesViewModel)
                            #if os(iOS)
                            .navigationBarTitleDisplayMode(.inline)
                            #endif
                    } label: {
                        SimpleBookSalesView(salesViewModel: salesViewModel)
                    }
                }
                Section {
                    NavigationLink {
                        SalesByWeekDayView(salesViewModel: salesViewModel)
                            #if os(iOS)
                            .navigationBarTitleDisplayMode(.inline)
                            #endif
                    } label: {
                        SimpleSalesByWeekdayView(salesViewModel: salesViewModel)
                    }
                }
                Section {
                    NavigationLink {
                        SalesPerBookCategoryView(salesViewModel: salesViewModel)
                            #if os(iOS)
                            .navigationBarTitleDisplayMode(.inline)
                            #endif
                    } label: {
                        SimpleSalesPerBookCategoryView(salesViewModel: salesViewModel)
                    }
                }
                Section {
                    NavigationLink {
                        DetailExpensesView(expensesViewModel: expensesViewModel)
                            #if os(iOS)
                            .navigationBarTitleDisplayMode(.inline)
                            #endif
                    } label: {
                        SimpleExpensesLineChartView(expensesViewModel: expensesViewModel)
                    }
                }
            }
            .navigationTitle("Your book store stats")
        }
    }
}

//#Preview {
//    ContentView()
//}
