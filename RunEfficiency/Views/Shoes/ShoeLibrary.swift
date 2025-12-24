//
//  ShoeLibrary.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/23/25.
//

import SwiftUI

struct ShoeLibrary: View {
    @EnvironmentObject var shoeStore: ShoeStore

    @State private var showingAddShoe = false
    @State private var shoeToEditId: Shoe.ID?

    var body: some View {
        VStack(spacing: 12) {
            ForEach(shoeStore.shoes) { shoe in
                ShoeRow(
                    shoe: shoe,
                    onDelete: {
                        shoeStore.deleteShoe(shoe)
                    },
                    onEdit: {
                        shoeToEditId = shoe.id
                    }
                )
            }

            Button {
                showingAddShoe = true
            } label: {
                Label("Add Shoe", systemImage: "plus")
                    .font(.headline)
            }
            .padding(.top)
        }
        // EDIT EXISTING SHOE
        .sheet(isPresented: Binding(
            get: { shoeToEditId != nil },
            set: { if !$0 { shoeToEditId = nil } }
        )) {
            if let id = shoeToEditId,
               let index = shoeStore.shoes.firstIndex(where: { $0.id == id }) {
                AddShoeView(shoeToEdit: $shoeStore.shoes[index], isNew: false)
                    .environmentObject(shoeStore)
            }
        }
        // ADD NEW SHOE
        .sheet(isPresented: $showingAddShoe) {
            AddShoeView(
                shoeToEdit: .constant(Shoe.empty),
                isNew: true
            )
            .environmentObject(shoeStore)
        }
    }
}

#Preview {
    ShoeLibrary()
        .environmentObject(ShoeStore())
}
