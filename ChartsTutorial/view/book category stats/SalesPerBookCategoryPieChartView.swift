import SwiftUI
import Charts

struct SalesPerBookCategoryPieChartView: View {
    @ObservedObject var salesViewModel: SalesViewModel
    
    var body: some View {
                    
        Chart(salesViewModel.totalSalesPerCategory, id: \.category) { data in
            SectorMark(angle: .value("Book Cateogyr", data.sales), innerRadius: .ratio(0.618), angularInset: 1)
                .cornerRadius(5)
                .opacity(salesViewModel.bestSellingCategory?.category == data.category ? 1 : 0.3)
                .foregroundStyle(by: .value("Category", data.category.displayName))
            
        }
        .aspectRatio(1, contentMode: .fit)
        .chartLegend(position: .bottom, spacing: 20)
        .chartBackground { chartProxy in
            GeometryReader(content: { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                let visibleSize = min(frame.width, frame.height)
                if let bestSellingCategory = salesViewModel.bestSellingCategory {
                    VStack {
                        Text("Most Sold Category").font(.callout)
                        Text(bestSellingCategory.category.displayName).font(.title2.bold()).foregroundColor(.primary)
                        Text(bestSellingCategory.sales.formatted() + " sold").font(.callout).foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: visibleSize * 0.618, maxHeight: visibleSize * 0.618)
                    .position(x: frame.midX, y: frame.midY)
                }
            })
        }
    }
}

//#Preview {
//    SalesPerBookCategoryPieChartView(salesViewModel: .preview)
//        .padding()
//}
