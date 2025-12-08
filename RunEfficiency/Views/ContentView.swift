//
//  ContentView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userProfileStore = UserProfileStore()
    
    var body: some View {
        DashboardView()
            .environmentObject(userProfileStore)
    }
}

#Preview {
    ContentView()
}
