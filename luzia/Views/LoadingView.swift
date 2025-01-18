//
//  LoadingView.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .padding(20)
                .background(Color.white)
                .cornerRadius(10)
                .transition(.opacity)
        }
    }
}

#Preview {
    LoadingView()
}
