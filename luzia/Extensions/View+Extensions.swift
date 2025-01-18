//
//  ViewExtensions.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftUI

extension View {
    func toast(isPresented: Binding<Bool>, message: String, duration: TimeInterval? = nil) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue {
                VStack {
                    Spacer()
                    ToastView(message: message)
                        .onAppear {
                            if let duration {
                                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                    withAnimation {
                                        isPresented.wrappedValue = false
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
}
