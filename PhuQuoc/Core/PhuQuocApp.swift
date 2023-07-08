//
//  PhuQuocApp.swift
//  PhuQuoc
//
//  Created by Aleksander Pankow on 27/05/2023.
//

import SwiftUI
import Firebase

@main
struct PhuQuocApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
