//
//  DashboardView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI
import CoreData

struct DashboardView: View {
    @EnvironmentObject var userProfileStore: UserProfileStore
    @EnvironmentObject var shoeStore: ShoeStore
    @EnvironmentObject var runRepository: CoreDataRunRepository

    @State private var showingProfile: Bool = false
    
    // viewModel is created in ContentView and passed to DashboardView using singleton runRepository
    var viewModel: DashboardViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    TrendView(points: viewModel.points)
                    RunsListView(runs: viewModel.runs)
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
    DashboardView(viewModel: DashboardViewModel(runRepository: CoreDataRunRepository(context: PersistenceController.shared.container.viewContext)))
        .environmentObject(UserProfileStore())
        .environmentObject(ShoeStore())
        .environmentObject(CoreDataRunRepository(context: PersistenceController.shared.container.viewContext))
}
