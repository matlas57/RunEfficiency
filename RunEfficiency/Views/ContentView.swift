//
//  ContentView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var userProfileStore = UserProfileStore()
    @StateObject private var shoeStore = ShoeStore()
    @StateObject private var runRepository = CoreDataRunRepository(
        context: PersistenceController.shared.container.viewContext
    )
    
    var body: some View {
        DashboardView(viewModel: DashboardViewModel(runRepository: runRepository))
            .environmentObject(userProfileStore)
            .environmentObject(shoeStore)
            .environmentObject(runRepository)
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext,
              PersistenceController.preview.container.viewContext)
}
