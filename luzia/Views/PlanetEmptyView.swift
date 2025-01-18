//
//  PlanetEmptyView.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftUI

struct PlanetEmptyView: View {
    let action: () -> Void

    var body: some View {
        VStack {
            Text("No planets available")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
            Button("Try Again") {
                action()
            }
            Spacer()
                .padding()
        }
    }
}

#Preview {
    PlanetEmptyView { }
}
