//
//  ContentView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject private var appDataController: AppDataController
    
    @StateObject private var userProfileStore = UserProfileStore()
    @StateObject private var shoeStore = ShoeStore()
    
    var body: some View {
        DashboardView(viewModel: DashboardViewModel(appDataController: appDataController))
            .environmentObject(userProfileStore)
            .environmentObject(shoeStore)
            .onAppear {
                appDataController.bootstrapIfNeeded()
            }
    }
}

#Preview {
    let previewController: AppDataController = {
        // 1. Load runs from JSON
        let jsonRepo = JSONRunRepository(loader: GarminBatchImporter())
        let sampleRuns: [Run]
        do {
            sampleRuns = try jsonRepo.fetchAllRuns().sorted { $0.date > $1.date }
        } catch {
            sampleRuns = []
            print("Failed to load JSON preview runs:", error)
        }

        // 2. Initialize controller
        let controller = AppDataController(
            runRepository: CoreDataRunRepository(
                context: PersistenceController.preview.container.viewContext
            ),
            economyScoreStore: EconomyScoreStore()
        )
        

        // 3. Save runs and recompute
        controller.savePreviewRuns(sampleRuns)

        return controller
    }()
    
    ContentView()
        .environment(\.managedObjectContext,
                     PersistenceController.preview.container.viewContext)
        .environmentObject(previewController)
}
