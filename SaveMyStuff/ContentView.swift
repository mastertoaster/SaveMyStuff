//
//  ContentView.swift
//  SaveMyStuff
//
//  Created by Andreas Gjaerum on 11/12/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var logging: LoggingObservable
    
    @State private var incrementor: Int = 0
    
    var body: some View {
        VStack {
            Button {
                incrementor += 1
                logging.appendLog("New line \(incrementor)")
            } label: {
                Text("Add log")
            }
            .padding(.bottom, 40)

            Button {
                logging.saveLogs()
            } label: {
                Text("Save")
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
