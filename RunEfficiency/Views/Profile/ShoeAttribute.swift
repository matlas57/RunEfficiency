//
//  ShoeAttribute.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/23/25.
//

import SwiftUI

struct ShoeAttribute: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(value)
                .font(.subheadline)
        }
    }
}

#Preview {
    ShoeAttribute(label: "Stack", value: "35")
}
