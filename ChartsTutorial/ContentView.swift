import SwiftUI

struct ContentView: View {
    
    @StateObject var salesViewModel = SalesViewModel.preview
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    DetailBookSalesView(salesViewModel: salesViewModel)
                } label: {
                    SimpleBookSalesView(salesViewModel: salesViewModel)
                }
            }
            .navigationTitle("Your book store stats")
        }
    }
}

#Preview {
    ContentView()
}
