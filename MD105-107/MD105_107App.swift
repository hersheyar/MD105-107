//
//  MD105_107App.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/11/25.
//

import SwiftUI
import SwiftData

@main
struct MD105_107App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [PersistentCharacter.self])
    }
}
