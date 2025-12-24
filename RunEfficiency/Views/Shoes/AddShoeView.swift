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

    @Binding var shoeToEdit: Shoe
    let isNew: Bool

    @State private var name: String = ""
    @State private var stackHeight: String = ""
    @State private var drop: String = ""
    @State private var hasPlate: Bool = false

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
            .navigationTitle(isNew ? "Add Shoe" : "Edit Shoe")
            .onAppear {
                // Initialize state from the binding
                name = shoeToEdit.name
                stackHeight = String(shoeToEdit.stackHeightMm ?? 0)
                drop =  String(shoeToEdit.dropMm ?? 0)
                hasPlate = shoeToEdit.hasCarbonPlate
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Write local state back to binding
                        shoeToEdit.name = name
                        shoeToEdit.stackHeightMm = Double(stackHeight)
                        shoeToEdit.dropMm = Double(drop)
                        shoeToEdit.hasCarbonPlate = hasPlate

                        if isNew {
                            shoeStore.addShoe(shoe: shoeToEdit)
                        } else {
                            shoeStore.updateShoe(shoeToEdit)
                        }

                        dismiss()
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
}


