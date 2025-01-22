//
//  ResidentView.swift
//  luzia
//
//  Created by Inigo Mato on 22/01/2025.
//

import SwiftUI

struct ResidentView: View {
    var resident: PeopleResponse

    var body: some View {
        VStack(spacing: 20) {
            Text(resident.name)
                .font(.system(size: 34, weight: .bold))
                .padding(.top, 20)
            VStack(spacing: 16) {
                InfoRow(title: "Mass", value: resident.mass)
                InfoRow(title: "Height", value: resident.height)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 5)
            )
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ResidentView(resident: PeopleResponse.Mock)
}
