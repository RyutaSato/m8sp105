//
//  EmergencyModel.swift
//  m8sp105
//
//  Created by 佐藤竜太 on 2021/02/10.
//

import Foundation
import Combine

struct EmergencyList:Decodable{
    var name:String
    var date:DateComponents
    var duration:Int
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
