//
//  GraphBundle.swift
//  Graph
//
//  Created by Геннадий Машталяр on 24.03.2024.
//

import WidgetKit
import SwiftUI

@main
struct GraphBundle: WidgetBundle {
    var body: some Widget {
        Graph()
        GraphLiveActivity()
    }
}
