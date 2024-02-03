import SwiftUI

struct DetailExpensesView: View {
    
    @ObservedObject var expensesViewModel: ExpensesViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DetailExpensesView(expensesViewModel: .preview)
}
