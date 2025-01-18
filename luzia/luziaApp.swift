//
//  luziaApp.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import SwiftUI

@main
struct luziaApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Planet.self)
        .environmentObject(networkMonitor)
    }
}
