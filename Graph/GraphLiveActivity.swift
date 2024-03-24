//
//  GraphLiveActivity.swift
//  Graph
//
//  Created by Геннадий Машталяр on 24.03.2024.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct GraphAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct GraphLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: GraphAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension GraphAttributes {
    fileprivate static var preview: GraphAttributes {
        GraphAttributes(name: "World")
    }
}

extension GraphAttributes.ContentState {
    fileprivate static var smiley: GraphAttributes.ContentState {
        GraphAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: GraphAttributes.ContentState {
         GraphAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: GraphAttributes.preview) {
   GraphLiveActivity()
} contentStates: {
    GraphAttributes.ContentState.smiley
    GraphAttributes.ContentState.starEyes
}
