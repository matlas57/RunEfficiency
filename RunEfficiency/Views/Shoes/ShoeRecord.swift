//
//  ShoeRecord.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/23/25.
//

import SwiftUI

struct ShoeRecord: View {
    var shoe: Shoe
    var body: some View {
        VStack(alignment: .leading) {
            Text(shoe.name)
                .font(.headline)
                .padding(.bottom, 4)
            HStack(spacing: 24) {
                if let stack = shoe.stackHeightMm {
                    ShoeAttribute(label: "Stack", value: "\(Int(stack)) mm")
                }
                if let drop = shoe.dropMm {
                    ShoeAttribute(label: "Drop", value: "\(Int(drop)) mm")
                }
                if let plate = shoe.hasCarbonPlate {
                    ShoeAttribute(
                        label: "Has Plate",
                        value: plate ? "Yes" : "No"
                    )
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    ShoeRecord(shoe: Shoe(name: "NB Rebel", brand: "New Balance", stackHeightMm: 35.0, dropMm: 6.0, hasCarbonPlate: false))
}
