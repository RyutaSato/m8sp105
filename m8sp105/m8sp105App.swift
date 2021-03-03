//
//  m8sp105App.swift
//  m8sp105
//
//  Created by 佐藤竜太 on 2021/02/07.
//

import SwiftUI
import WidgetKit

@main
struct m8sp105App: App {
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                //アプリの変更に応じてwidgetを更新するメソッド
                .onChange(of: scenePhase) { newScenePhase in
                    if newScenePhase == .active{
                        WidgetCenter.shared.reloadTimelines(ofKind: "m8sp105widget")
                    }
                }
        }
    }
}
