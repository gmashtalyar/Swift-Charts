import SwiftUI

struct ExpensesDetailGridView: View {
    
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    var body: some View {
        Grid(alignment: .trailing, horizontalSpacing: 15, verticalSpacing: 10) {
            
            GridRow {
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                Text("Fixed")
                    .gridCellAnchor(.center)
                Text("Variable")
                    .gridCellAnchor(.center)
                Text("Total")
                    .gridCellAnchor(.center)
            }
            Divider()
            ForEach(expensesViewModel.monthlyExpenseData) { data in
                GridRow {
                    Text(month(for: data.month))
                    Text(String(format: "%.2f", data.fixedExpense))
                    Text(String(format: "%.2f", data.variableExpense))
                    Text(String(format: "%.2f", data.totalExpense)).bold()
                }
            }
            Divider()
            GridRow {
                Text("Total").bold()
                Color.clear.gridCellUnsizedAxes([.horizontal, .vertical])
                    .gridCellColumns(2)
                Text("$" + String(format: "%.2f", expensesViewModel.totalExpenses)).bold().foregroundStyle(.pink)
            }
        }
    }
    
    let formatter = DateFormatter()
    func month(for number: Int) -> String {
        formatter.shortStandaloneMonthSymbols[number - 1]
    }
}

#Preview {
    ExpensesDetailGridView(expensesViewModel: .preview)
}
