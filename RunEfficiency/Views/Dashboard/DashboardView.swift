//
//  DashboardView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var userProfileStore: UserProfileStore
    @EnvironmentObject var shoeStore: ShoeStore
    
    @StateObject private var viewModel = DashboardViewModel()
    @State private var showingProfile: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    TrendView(points: viewModel.points)
                    RunsListView(runs: viewModel.runs)
                        .environmentObject(userProfileStore)
                        .environmentObject(shoeStore)
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(UserProfileStore())
        .environmentObject(ShoeStore())
}
