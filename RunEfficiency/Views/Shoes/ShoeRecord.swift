//
//  ShoeRecord.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/23/25.
//

import SwiftUI

struct ShoeRecord: View {
    let shoe: Shoe

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(shoe.name)
                .font(.headline)

            HStack(spacing: 8) {
                if let stack = shoe.stackHeightMm {
                    Text("Stack: \(stack, specifier: "%.1f") mm")
                }
                if let drop = shoe.dropMm {
                    Text("Drop: \(drop, specifier: "%.1f") mm")
                }
                

                if shoe.hasCarbonPlate == true {
                    Text("Plated")
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ShoeRecord(shoe: Shoe(name: "NB Rebel", brand: "New Balance", stackHeightMm: 35.0, dropMm: 6.0, hasCarbonPlate: false))
}
