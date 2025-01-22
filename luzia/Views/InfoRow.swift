//
//  InfoRow.swift
//  luzia
//
//  Created by Inigo Mato on 22/01/2025.
//

import SwiftUI

struct InfoRow: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    InfoRow(title: "Title", value: "Value")
}
