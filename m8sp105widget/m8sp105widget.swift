//
//  m8sp105widget.swift
//  m8sp105widget
//
//  Created by 佐藤竜太 on 2021/03/01.
//
import WidgetKit
import SwiftUI
import UIKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        //ほとんど呼ばれることがないため，既定値のみで基本何も書かない
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
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
            let entry = SimpleEntry(date: Calendar.current.date(byAdding: .hour, value: hourOffset, to: Date())!)
            entries.append(entry)
        }
        //let dateConponents = DateComponents(second:10)
        //let futureTime = Calendar.current.date(byAdding: dateConponents, to: Date())

        //Timeline型はViewをどのように更新するか決定する
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
        //NEXT!!!!!!
        
    }
}

struct m8sp105widgetEntryView : View {
    var entry: Provider.Entry
    var serverState: ServerState = .inError
    @State var isInEmergency = true
    @State var isInMentenance = false
    

    var body: some View {
        let emergencyDate = SimpleEntry(date: Date())

        let displayDate:Date = Calendar.current.date(byAdding: .second, value:0 ,to: emergencyDate.emergencyEnd)!
        ZStack{
            Color.init(backgroundColorName(serverState: serverState))
            VStack{
                //Text(entry.date, style: .time)
                if isInMentenance{
                    Text("PSO2はメンテナンス中です．..\n終了まで")
                }else if isInEmergency {
                    HStack{
                        Text(entry.emergencyName)
                        Text("発生中")
                    }
                }else{
                    Image(systemName: "mentenance.xcassets")
                    Text("次の緊急は")
                }
                Text(displayDate, style: .timer)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 40.0,design:.serif))
                
                HStack{
                    Text("22:30")
                        .multilineTextAlignment(.leading)
                    //Spacer()
                    Text("掃討作戦：夢幻のごとく")
                        .multilineTextAlignment(.trailing)
                }
                HStack{
                    Text("00:30")
                        .multilineTextAlignment(.leading)
                    //Spacer()
                    Text("掃討作戦：夢幻のごとく")
                        .multilineTextAlignment(.trailing)
                }
                HStack{
                    Text("00:30")
                        .multilineTextAlignment(.leading)
                    //Spacer()
                    Text("掃討作戦：夢幻のごとく")
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
    private func backgroundColorName(serverState:ServerState)->String{
        switch serverState{
            case .inError:
                return "emergency"
            case .inMentenance:
                return "mentenance"
            case .inNomal:
                return "nomal"
            case .inEmergencyMentenance:
                return "mentenance"
            case .inLive:
                return "nomal"
            case .inEmergency:
                return "emergency"
        }
    }
    
}

@main
struct m8sp105widget: Widget {
    let kind: String = "PSO2NGS STATUS"

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
    static var simpleEntry_Previews = SimpleEntry(date: Date())
    
    static var previews: some View {
        Group{
            //m8sp105widgetEntryView(entry: SimpleEntry(date: Date()))
                //.previewContext(WidgetPreviewContext(family: .systemSmall))
            m8sp105widgetEntryView(entry: simpleEntry_Previews)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            m8sp105widgetEntryView(entry: simpleEntry_Previews)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .environment(\.colorScheme, .dark)
            m8sp105widgetEntryView(entry: simpleEntry_Previews)
                .redacted(reason: /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
        }
        
    }
}
