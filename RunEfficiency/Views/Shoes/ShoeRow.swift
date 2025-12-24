//
//  ShoeRow.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/23/25.
//

import SwiftUI

struct ShoeRow: View {
    let shoe: Shoe
    let onDelete: () -> Void
    let onEdit: () -> Void
    
    var body: some View {
        HStack {
            ShoeRecord(shoe: shoe)

            Spacer()

            Menu {
                Button("Edit Shoe") {
                    onEdit()
                }

                Button("Delete Shoe", role: .destructive) {
                    onDelete()
                }
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .padding(.horizontal, 8)
            }
        }
        .contentShape(Rectangle()) // ensures proper hit testing
    }
}
