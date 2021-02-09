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
                
                
            }
            
            
            
        }
        
    }
}
//func culcTime


struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
            .previewLayout(.fixed(width: 300, height: 200))
            
    }
}
