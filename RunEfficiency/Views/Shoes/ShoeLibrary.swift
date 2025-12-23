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
    
    var body: some View {
        VStack {
            ForEach(shoeStore.shoes, id: \.self) { shoe in
                ShoeRecord(shoe: shoe)
            }
            
            Button {
                showingAddShoe = true
            } label: {
                Label("Add Shoe", systemImage: "plus")
                    .font(.headline)
            }
            .padding()
        }
        .sheet(isPresented: $showingAddShoe) {
            AddShoeView()
        }
    }
}

#Preview {
    ShoeLibrary()
        .environmentObject(ShoeStore())
}
