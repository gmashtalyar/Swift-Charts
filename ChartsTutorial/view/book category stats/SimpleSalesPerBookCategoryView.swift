import SwiftUI
import Charts

struct SimpleSalesPerBookCategoryView: View {
    
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
        HStack {
            SalesPerBookCategoryHeaderView(salesViewModel: salesViewModel)
        }
    }
}

#Preview {
    SimpleSalesPerBookCategoryView(salesViewModel: .preview)
}
