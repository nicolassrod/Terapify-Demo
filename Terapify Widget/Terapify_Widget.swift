//
//  Terapify_Widget.swift
//  Terapify Widget
//
//  Created by Nicolás A. Rodríguez on 7/14/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry

    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct PlaceholderView : View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("Image")
            Text("Gabriela Aguirre León")
            Text(Date(), style: .relative)
        }
    }
}

struct Terapify_WidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color("AccentColor")
            VStack(alignment: .leading) {
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(Image("terapify")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle()),
                             alignment: .bottomTrailing)
                Text("Gabriela Aguirre León")
                    .fontWeight(.bold)
                HStack(alignment: .firstTextBaseline, spacing: 3) {
                    Text("En:")
                    Text(getDate(), style: .offset)
                }
            }.padding(.all, 8)
        }
        .foregroundColor(.white)
    }
    
    func getDate() -> Date {
        let currentDate = Date()
        return Calendar.current.date(byAdding: .minute, value: 15, to: currentDate)!
    }
}

@main
struct Terapify_Widget: Widget {
    private let kind: String = "Terapify_Widget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            Terapify_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
