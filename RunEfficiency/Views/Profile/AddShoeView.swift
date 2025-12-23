//
//  AddShoeView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/23/25.
//

import SwiftUI

struct AddShoeView: View {
    @EnvironmentObject var shoeStore: ShoeStore
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var stackHeight: String = ""
    @State private var drop: String = ""
    @State private var hasPlate: Bool = false
    
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Shoe Details")) {
                    TextField("Name", text: $name)

                    TextField("Stack Height (mm)", text: $stackHeight)
                        .keyboardType(.decimalPad)

                    TextField("Drop (mm)", text: $drop)
                        .keyboardType(.decimalPad)

                    Toggle("Plated", isOn: $hasPlate)
                }
            }
            .navigationTitle("Add Shoe")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveShoe()
                    }
                    .disabled(name.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func saveShoe() {
        let shoe = Shoe(
            id: UUID(),
            name: name,
            stackHeightMm: Double(stackHeight),
            dropMm: Double(drop),
            hasCarbonPlate: hasPlate
        )

        shoeStore.addShoe(shoe: shoe)
        dismiss()
    }
}

#Preview {
    AddShoeView()
}
