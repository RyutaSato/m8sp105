//
//  EmergencyModel.swift
//  m8sp105
//
//  Created by 佐藤竜太 on 2021/02/10.
//

import Foundation
import Combine
import SwiftUI

struct EmergencyList:Decodable{
    
    var name:String
    var srtDate:Date
    var duration:Int = 30
    var endDate:Date
    
    init(name:String, date:String, duration:Int?){
        func dateFromString(_ dateSting : String) -> Date {
            // DateFormatter のインスタンスを作成
            let formatter: DateFormatter = DateFormatter()
            // 日付の書式を文字列に合わせて設定
            formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            
            // 日時文字列からDate型の日付を生成する
            let dt = formatter.date(from: dateSting)
            
            return dt!
        }
        self.name = name
        self.srtDate = dateFromString(date)
        if (duration != nil) {
            self.duration = duration!
            self.endDate = srtDate.addingTimeInterval(TimeInterval(duration! * 60))
        }else{
            self.endDate = srtDate.addingTimeInterval(TimeInterval(30 * 60))
        }
    }
}
struct MentenanceStatus {
    var serverState:ServerState = .inError
    var isNextRegularMente:Bool = true
    var isNotKnowEndDate:Bool = false
    let endDateUpdateDate:Date? = nil
    let endDate:Date? = nil
    let regularMenteDay:Week = .wed
    let regularMenteSrtHour:Int = 11
    let regularMenteEndHour:Int = 17
    
    enum Week {
        case sun
        case mon
        case tue
        case wed
        case thu
        case fri
        case sat
    }
    
    init(isMentenance:Bool = false, isEmergency:Bool = false, isExtended:Bool = false, endDate:String?, forrowUpdate:String?){
        /*
         isEmergency: 緊急メンテナンス中かどうか
         menteEndDate?: メンテナンス終了予定時刻(公表されている場合)
         forrowUpdate?: メンテナンス終了時刻が分からない場合の続報のお知らせ予定時刻(公表されている場合)
         */
        if isMentenance{
            //緊急メンテナンスの場合
            if isEmergency{
                self.serverState = .inEmergencyMentenance
                //endDateにDate型で追加する
                //UpdateDateにも同じ時間を追加
                if (endDate != nil){
                    
                //UpdateDateに追加
                }else if(forrowUpdate != nil){
                    
                //終了時刻も，続報時刻も分からない場合
                }else{
                    self.isNotKnowEndDate = true
                }
            //定期メンテナンスの場合
            }else{
                self.serverState = .inMentenance
                //延長していたら
                if isExtended{
                    if (endDate != nil){
                        
                    //UpdateDateに追加
                    }else if(forrowUpdate != nil){
                        
                    //終了時刻も，続報時刻も分からない場合
                    }else{
                        self.isNotKnowEndDate = true
                    }
                //通常通りであれば
                }else{
                    //DO
                }
            }
        }
    }
}


enum ServerState {
    case inMentenance
    case inEmergencyMentenance
    case inEmergency
    case inLive
    case inNomal
    case inError
}

final class ModelData: ObservableObject {
    @Published var emergencyList: [EmergencyList] = load("preData.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
