//
//  RunEfficiencyApp.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI
import CoreData

@main
struct RunningEconomyApp: App {
    let persistenceController = PersistenceController.shared
    let appDataController: AppDataController
    
    init() {
        let runRepository = CoreDataRunRepository(
            context: persistenceController.container.viewContext
        )

        let economyScoreStore = EconomyScoreStore()

        self.appDataController = AppDataController(
            runRepository: runRepository,
            economyScoreStore: economyScoreStore
        )
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
                .environmentObject(appDataController)
        }
    }
}
