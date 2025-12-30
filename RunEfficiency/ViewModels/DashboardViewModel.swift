//
//  DashboardViewModel.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import Foundation
import Combine
import CoreData

class DashboardViewModel: ObservableObject {
    @Published var runs: [Run] = []
    //private(set) means the property can be read publically but only written inside this type. Guarantees that updatePoints is the only way points is modified
    @Published private(set) var points: [RunningEconomyPoint] = []
    
    private let batchImporter = GarminBatchImporter()
    
    private let repository = JSONRunRepository(loader: GarminBatchImporter())
    
    let coreDataRepo = CoreDataRunRepository(
        context: PersistenceController.shared.container.viewContext
    )
    
    init() {
        loadGarminRuns()
        updatePoints()
    }
    
    private func loadGarminRuns() {
        do {
            let importedRuns = try repository.fetchAllRuns()
            self.runs = importedRuns.sorted { $0.date > $1.date }
            for run in runs {
                try coreDataRepo.save(run: run)
            }
        } catch {
            print("Failed to import Garmin runs:", error)
        }
    }
    
    // update points in a function called on init to avoid recomputing points on every refresh
    private func updatePoints() {
        points = runs
            .map { run in
                RunningEconomyPoint(
                    date: run.date,
                    efficiencyScore: RunningEconomyCalculator.computeEconomyScore(for: run)
                )
            }
            .sorted { $0.date < $1.date }
    }
}
