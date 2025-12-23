//
//  ContentView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userProfileStore = UserProfileStore()
    @StateObject private var shoeStore = ShoeStore()
    
    var body: some View {
        DashboardView()
            .environmentObject(userProfileStore)
            .environmentObject(shoeStore)
    }
}

#Preview {
    ContentView()
}
