//
//  EmergencyView.swift
//  m8sp105
//
//  Created by 佐藤竜太 on 2021/02/09.
//

import SwiftUI

struct EmergencyView: View {
    let components = DateComponents(minute: 0,second: 10)
    @State var now = Date()
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    let name = "原初の闇"
    @State var min = 25
    @State var sec = 12
    
    var body: some View {
        
        let futureDate = Calendar.current.date(byAdding: components, to: Date(),wrappingComponents: true)!
        ZStack{
            Image("sodamu")
                .frame(width: 300.0, height: 100.0)
            VStack{
                Text(name)
                    .foregroundColor(Color.white)
                    .font(.system(size: 30.0))
                Text(futureDate, style: .timer)
                    .font(.system(size: 50.0,design:.serif))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.trailing)
                    .padding(5.0)
                Text(String(min) + " : " + String(sec))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.trailing)
                    .padding(5.0)
                
                
                
            }
            
            
            
        }
        
    }
}
func calcDateRemainder(firstDate: Date, secondDate: Date? = nil) -> Int{

    var retInterval:Double!
    let firstDateReset = resetTime(date: firstDate)

    if secondDate == nil {
        let nowDate: Date = Date()
        let nowDateReset = resetTime(date: nowDate)
        retInterval = firstDateReset.timeIntervalSince(nowDateReset)
    } else {
        let secondDateReset: Date = resetTime(date: secondDate!)
        retInterval = firstDate.timeIntervalSince(secondDateReset)
    }


    return Int(retInterval)  // n second
}

func resetTime(date: Date) -> Date {
    let calendar: Calendar = Calendar(identifier: .gregorian)
    var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

    components.hour = 0
    components.minute = 0
    components.second = 0

    return calendar.date(from: components)!
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
            .previewLayout(.fixed(width: 300, height: 200))
            
    }
}
