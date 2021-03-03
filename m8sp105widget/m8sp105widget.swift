//
//  m8sp105widget.swift
//  m8sp105widget
//
//  Created by 佐藤竜太 on 2021/03/01.
//
import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        //ほとんど呼ばれることがないため，既定値のみで基本何も書かない
        SimpleEntry(date: Date(), emergencyName: "(error)", emergencyStart: DateComponents(year:8888, month:8, day: 8, hour: 8, minute:88), emergencyDuration: DateComponents(minute: 88))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emergencyName: "(error)", emergencyStart: DateComponents(year:8888, month:8, day: 8, hour: 8, minute:88), emergencyDuration: DateComponents(minute: 88))
        if context.isPreview {
            completion(entry)
        } else {
            do {
                completion(entry)
            }
        }
        
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        //読み込むタイミングのスケジュールを書く
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        for hourOffset in 0 ..< 5 {
            //currentDate = Date()
            /*
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: Date())!
            let emergencyDuration = DateComponents(minute: 30)
            let emergencyStart = DateComponents(year:2021, month: 3, day: 4, hour: 19, minute: 0)
            */
            let entry = SimpleEntry(date: Calendar.current.date(byAdding: .hour, value: hourOffset, to: Date())!, emergencyName: "(load error!)", emergencyStart: DateComponents(year:2021, month: 3, day: 4, hour: 19, minute: 0),emergencyDuration: DateComponents(minute: 30))
            entries.append(entry)
        }
        //let dateConponents = DateComponents(second:10)
        //let futureTime = Calendar.current.date(byAdding: dateConponents, to: Date())

        //Timeline型はViewをどのように更新するか決定する
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emergencyName: String
    let emergencyStart: DateComponents
    let emergencyDuration: DateComponents
    init(date: Date, emergencyName: String, emergencyStart: DateComponents, emergencyDuration: DateComponents){
        self.date = date
        self.emergencyName = emergencyName
        self.emergencyStart = emergencyStart
        self.emergencyDuration = emergencyDuration
    }
}

struct m8sp105widgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        let emergencyDate = Calendar.current.date(byAdding: entry.emergencyDuration, to: entry.date)!

        ZStack{
            //Image("sodamu")
            VStack{
                Text(entry.date, style: .time)
                Text(entry.emergencyName)
                Text(emergencyDate, style: .timer)
                    .multilineTextAlignment(.center)
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
        .configurationDisplayName("PSO2NGS Emergency Widget")
        .description("You can receive emergency notices and mentenance status")
    }
}

struct m8sp105widget_Previews: PreviewProvider {
    //staticは必ずつけること！！！
    static var simpleEntry_Previews = SimpleEntry(date: Date(), emergencyName: "緊急クエスト", emergencyStart: DateComponents(year:2021, month: 3, day: 5, hour: 19, minute: 0), emergencyDuration: DateComponents(minute: 15))
    
    static var previews: some View {
        Group{
            //m8sp105widgetEntryView(entry: SimpleEntry(date: Date()))
                //.previewContext(WidgetPreviewContext(family: .systemSmall))
            m8sp105widgetEntryView(entry: simpleEntry_Previews)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            m8sp105widgetEntryView(entry: simpleEntry_Previews)
                .redacted(reason: /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            //m8sp105widgetEntryView(entry: SimpleEntry(date: Date()))
                //.previewContext(WidgetPreviewContext(family: .systemLarge))
        }
        
    }
}
