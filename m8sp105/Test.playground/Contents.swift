import UIKit
import SwiftUI
func dateFromString(_ dateSting : String) -> Date {
    // DateFormatter のインスタンスを作成
    let formatter: DateFormatter = DateFormatter()
    // 日付の書式を文字列に合わせて設定
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    
    // 日時文字列からDate型の日付を生成する
    let dt = formatter.date(from: dateSting)
    
    return dt!
}
func initDateFormatter() -> DateFormatter{
    let format = DateFormatter()
    format.locale = Locale(identifier: "Ja_JP")
    format.dateFormat = "yyyy/MM/dd HH:mm:ss"
    
    return format
}
let dtStr = "2021/03/10 12:15:00"
let dateFormatter = initDateFormatter()
let dt:Date = dateFromString(dtStr)

let cal = Calendar(identifier: .gregorian)
let date1 = Date()
let date2 = date1.addingTimeInterval(-24 * 60)
let diff = cal.dateComponents([.second], from: date1, to: date2)


print(diff.second!)
print(dateFormatter.string(from: Date()))
