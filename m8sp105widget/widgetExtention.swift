//
//  widgetExtention.swift
//  m8sp105widgetExtension
//
//  Created by 佐藤竜太 on 2021/03/08.
//

import WidgetKit
import SwiftUI
//extension  m8sp105widgetEntryView{}
class GetTimeline{
    let format:DateFormatter
    init(){
        func initDateFormatter() -> DateFormatter{
            let format = DateFormatter()
            format.locale = Locale(identifier: "Ja_JP")
            format.dateFormat = "yyyy/MM/dd HH:mm"
            return format
        }
        self.format = initDateFormatter()
    }
    func dateFromString(_ dateSting : String) -> Date {
        // DateFormatter のインスタンスを作成
        let formatter: DateFormatter = DateFormatter()
        // 日付の書式を文字列に合わせて設定
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        // 日時文字列からDate型の日付を生成する
        let dt = formatter.date(from: dateSting)
        if(dt != nil){
            return dt!
        }
        return Date()
    }
    func initDateFormatter() -> DateFormatter{
        let format = DateFormatter()
        format.locale = Locale(identifier: "Ja_JP")
        format.dateFormat = "yyyy/MM/dd HH:mm"
        return format
    }
}
struct SimpleEntry: TimelineEntry {
    let date: Date
    let emergencyName: String
    let emergencyStart: Date
    let emergencyDuration: Int
    let emergencyEnd: Date
    init(date: Date){
        let emergencyName:String = "Reloading..."
        let emergencyStart:String = "2000/03/15 00:00"
        let emergencyDuration:Int = 30
        let getTimeline = GetTimeline()
        self.date = date
        self.emergencyName = emergencyName
        self.emergencyStart = getTimeline.dateFromString(emergencyStart)
        self.emergencyDuration = emergencyDuration
        self.emergencyEnd = self.emergencyStart.addingTimeInterval(TimeInterval(emergencyDuration))
    }
    
}
