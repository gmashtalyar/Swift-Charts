import WidgetKit
import SwiftUI

struct Model: TimelineEntry {
    var date: Date
    var widgetData: [JSONModel]
}

struct JSONModel: Decodable, Hashable {
    var date: CGFloat
    var units: Int
}

struct Provider: TimelineProvider {
    typealias Entry = Model
    
    func getSnapshot(in context: Context, completion: @escaping (Model) -> ()) {
        let loadingData = Model(date: Date(), widgetData: Array(repeating: JSONModel(date: 0, units: 0), count: 6))
        completion(loadingData)
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Model>) -> ()) {
        getData{ (modelData) in
            let date = Date()
            let data = Model(date: date, widgetData: modelData)
            
            let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: date)
            let timeline = Timeline(entries: [data], policy: .after(nextUpdate!))
            completion(timeline)
        }
    }
    func placeholder(in with: Context) -> Model {
        return Model(date: Date(), widgetData: Array(repeating: JSONModel(date: 0, units: 0), count: 6))
    }
    
}



struct WidgetView: View {
    var data: Model
    var colors = [Color.red, Color.yellow, Color.red, Color.blue, Color.green, Color.pink, Color.purple]
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 15) {
                Text("Units Sold").font(.title).fontWeight(.bold)
                Text(Date(), style: .time).font(.caption2)
            }.padding()
            HStack(spacing: 15) {
                ForEach(data.widgetData, id: \.self) { value in
                    if value.units == 0 && value.date == 0{
                        RoundedRectangle(cornerRadius: 5).fill(Color.gray)
                    } else {
                        VStack(spacing: 15) {
                            Text("\(value.units)").fontWeight(.bold)
                            GeometryReader{ g in
                                VStack{
                                    Spacer(minLength: 0)
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(colors.randomElement()!)
                                        .frame(height: getHeight(value: CGFloat(value.units), height: g.frame(in: .global).height))
                                }
                            }
                            Text(getData(value: value.date)).font(.caption2)
                        }
                    }
                }
            }
        }
    }
    func getHeight(value: CGFloat, height: CGFloat)->CGFloat {
        let max = data.widgetData.max { (first, second) -> Bool in
            if first.units > second.units{return false}
            else {return true}
        }
        let percent = value / CGFloat(max!.units)
        return percent * height
    }
    func getData(value: CGFloat)-> String{
        let format = DateFormatter()
        format.dateFormat = "MMM dd"
        let date = Date(timeIntervalSince1970: Double(value) / 1000.0)
        return format.string(from: date)
    }
}

@main
struct MainWidget: Widget {
    var body: some WidgetConfiguration{
        StaticConfiguration(kind: "Graph", provider: Provider()){ data in
            WidgetView(data: data)
        }
        .description(Text("Daily Status"))
        .configurationDisplayName(Text("Daily Updates"))
        .supportedFamilies([.systemLarge])
    }
}

func getData(completion: @escaping ([JSONModel]) -> ()) {
    let url = "https://canvasjs.com/data/gallery/javascript/daily-sales-data.json"
    let session = URLSession(configuration: .default)
    session.dataTask(with: URL(string: url)!) { (data, _, error) in
        if error != nil {
            print(error!.localizedDescription)
            return}
        do {
            let jsonData = try JSONDecoder().decode([JSONModel].self, from: data!)
            completion(jsonData)
        } catch {
            print(error.localizedDescription)
        }
    }.resume()
}
