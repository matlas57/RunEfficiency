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
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        self.runs = MockData.sampleRuns.sorted { $0.date > $1.date } //load runs newest to oldest
    }
    
    var points: [RunningEconomyPoint] {
        runs.map {run in
            RunningEconomyPoint(date: run.date, efficiencyScore: run.efficiencyScore)
        }
        .sorted { $0.date < $1.date }
    }
}
