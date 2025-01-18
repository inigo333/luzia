//
//  ToastView.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftUI

struct ToastView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .transition(.opacity)
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.bottom, 0)
    }
}

#Preview {
    ToastView(message: "Foo")
}
