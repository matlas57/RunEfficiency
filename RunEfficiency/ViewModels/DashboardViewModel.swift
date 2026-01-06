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
    //private(set) means the property can be read publically but only written inside this type. Guarantees that updatePoints is the only way points is modified
    @Published private(set) var runs: [Run] = []
    @Published private(set) var points: [RunningEconomyPoint] = []
    @Published private(set) var baselines: MechanicsBaselines?
    
    private let appDataController: AppDataController
    
    init(appDataController: AppDataController) {
        self.appDataController = appDataController

        // 1. Read persisted runs
        do {
            self.runs = try appDataController.fetchRuns()
                .sorted { $0.date > $1.date }
        } catch {
            self.runs = []
        }

        // 2. Read baselines (already computed during bootstrap)
        self.baselines = appDataController.economyScoreStore.mechanicsBaselines

        // 3. Derive points from existing data
        updatePoints()
    }
    
    
    // update points in a function called on init to avoid recomputing points on every refresh
    private func updatePoints() {
        points = appDataController.economyScoreStore.economyPoints(for: runs)
    }
}
