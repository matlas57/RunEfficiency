//
//  DashboardViewModel.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import Foundation
import Combine
import CoreData

final class DashboardViewModel: ObservableObject {
    @Published var runs: [Run] = []
    //private(set) means the property can be read publically but only written inside this type. Guarantees that updatePoints is the only way points is modified
    @Published private(set) var points: [RunningEconomyPoint] = []
    
    private let runRepository: any RunRepository
    private let batchImporter = GarminBatchImporter()
    private let JSONRepo = JSONRunRepository(loader: GarminBatchImporter())
    
    private let runningEconomyCalculator: RunningEconomyCalculator
    
    init(runRepository: any RunRepository) {
        self.runRepository = runRepository
        
        let baselineCalculator = BaselineCalculator(runRepository: runRepository)
        self.runningEconomyCalculator = RunningEconomyCalculator(baselineCalculator: baselineCalculator)
        
        loadGarminRuns()
        updatePoints()
    }
    
    //This will change once data is pulled directly from GarminDB
    private func loadGarminRuns() {
        do {
            let importedRuns = try JSONRepo.fetchAllRuns()
            self.runs = importedRuns.sorted { $0.date > $1.date }
            for run in runs {
                try runRepository.save(run: run)
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
                    efficiencyScore: runningEconomyCalculator.computeEconomyScore(for: run)
                )
            }
            .sorted { $0.date < $1.date }
    }
}
