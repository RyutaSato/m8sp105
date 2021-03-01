//
//  m8sp105widget.swift
//  m8sp105widget
//
//  Created by 佐藤竜太 on 2021/03/01.
//
import UIKit
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        let dateConponents = DateComponents(second:10)
        let futureTime = Calendar.current.date(byAdding: dateConponents, to: Date())

        let timeline = Timeline(entries: entries, policy: .after(futureTime!))
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let int: Int = 30
}

struct m8sp105widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        let components = DateComponents(minute: 15)

        ZStack{
            Image("sodamu")
            VStack{
                Text(entry.date, style: .time)
                    .foregroundColor(Color.white)
                Text("aaaa")
                    .foregroundColor(Color.white)
                Text(Calendar.current.date(byAdding: components, to: Date(),wrappingComponents: true)!, style: .timer)
                    .foregroundColor(Color.white)
                Text("aa")
            }
        }
        
        
    }
}

@main
struct m8sp105widget: Widget {
    let kind: String = "m8sp105widget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            m8sp105widgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct m8sp105widget_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            m8sp105widgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            m8sp105widgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            m8sp105widgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
        
    }
}
