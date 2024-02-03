import Foundation
import Combine

class ExpensesViewModel: ObservableObject {
    
    @Published private var expenses: [Expense] = []
    @Published var monthlyExpenseData: [ExpenseStates] = []
    @Published var totalExpenses: Double = 0
    
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        // fetch data from server
        
        $expenses.sink { [unowned self] expenses in
            let fixedExpense = self.expensesByMonth(for: .fixed, expenses: expenses)
            let variableExpense = self.expensesByMonth(for: .variable, expenses: expenses)
            self.monthlyExpenseData = self.calculateTotalMonthlyExpenses(fixedExpenses: fixedExpense, variableExpense: variableExpense)
            
            self.totalExpenses = self.calculateTotal(for: expenses)
        }
        .store(in: &subscriptions)
    }
    
    func expensesByMonth (for category: ExpenseCategory, expenses: [Expense]) -> [(month: Int, amount: Double)] {
        let calendar = Calendar.current
        var expensesByMonth: [Int: Double] = [:]
        
        for expense in expenses where expense.category == category {
            let month = calendar.component(.month, from: expense.expenseDate)
            expensesByMonth[month, default: 0] += expense.amount
        }
        let result = expensesByMonth.map { (month: $0.key, amount: $0.value) }
        
        return result.sorted { $0.month < $1.month }
    }
    
    func calculateTotalMonthlyExpenses(fixedExpenses: [(month: Int, amount: Double)],
                                       variableExpense: [(month: Int, amount: Double)]) -> [ExpenseStates] {
        var result = [ExpenseStates]()
        let count = min(fixedExpenses.count, variableExpense.count)
        
        for index in 0..<count {
            let month = fixedExpenses[index].month
            result.append(ExpenseStates(month: month, fixedExpense: fixedExpenses[index].amount, variableExpense: variableExpense[index].amount))
        }
        
        return result
    }
    
    func calculateTotal(for expenses: [Expense]) -> Double {
        let totalExpenses = expenses.reduce(0) { total, expense in
            total + expense.amount
        }
        return totalExpenses
    }
    
    // MARK: - preview
    
    static var preview: ExpensesViewModel {
        let vm = ExpensesViewModel()
        vm.expenses = Expense.yearExamples
        return vm
    }
}

struct ExpenseStates: Identifiable {
    let month: Int
    let fixedExpense: Double
    let variableExpense: Double
    
    var totalExpense: Double {
        fixedExpense + variableExpense
    }
    
    var id: Int {return month}
}
