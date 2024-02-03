import SwiftUI

@main
struct ChartsTutorialApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            ContentView()
            #else
            MacContentView()
            #endif
        }
    }
}
