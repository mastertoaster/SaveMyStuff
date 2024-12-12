//
//  SaveMyStuffApp.swift
//  SaveMyStuff
//
//  Created by Andreas Gjaerum on 11/12/2024.
//

import SwiftUI

@main
struct SaveMyStuffApp: App {
    let logging = LoggingObservable()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(logging)
        }
    }
}
