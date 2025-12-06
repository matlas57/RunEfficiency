//
//  DashboardViewModel.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var runs: [Run] = []
    //private(set) means the property can be read publically but only written inside this type. Guarantees that updatePoints is the only way points is modified
    @Published private(set) var points: [RunningEconomyPoint] = []
    @Published var userProfile: UserProfile = .init()
    
    init() {
        loadMockData()
        updatePoints()
    }
    
    private func loadMockData() {
        self.runs = MockData.sampleRuns.sorted { $0.date > $1.date } //load runs newest to oldest
        self.userProfile = MockData.sampleUserProfile
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
