//
//  ContentView.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        PlanetListView(modelContext: modelContext)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Planet.self, inMemory: true)
        .environmentObject(NetworkMonitor())
}
