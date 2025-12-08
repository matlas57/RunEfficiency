//
//  RunDetailViewModel.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/6/25.
//

import Foundation
import Combine

class RunDetailViewModel: ObservableObject {
    @Published var run: Run {
        didSet { recomputeAll() } //didSet observes a variable and executes the block below if the variable changes
    }
    @Published var userProfile: UserProfile
    @Published private(set) var economyScore = 0.0
    
    var dateString = ""
    var distanceString = ""
    var paceString = ""
    var elevationGainString = ""
    
    init(run: Run, userProfile: UserProfile) {
        self.run = run
        self.userProfile = userProfile
        recomputeAll()
        setFormattedStrings()
    }
    
    private func recomputeAll() {
        computeEconomyScore()
    }
    
    private func computeEconomyScore() {
        self.economyScore = RunningEconomyCalculator.computeEconomyScore(for: run)
    }
    
    private func setFormattedStrings() {
        self.dateString = RunFormatter.shared.dateString(for: run.date)
        self.distanceString = RunFormatter.shared.distanceString(for: run, units: userProfile.unitPreference)
        self.paceString = RunFormatter.shared.paceString(for: run, units: userProfile.unitPreference)
        self.elevationGainString = RunFormatter.shared.elevationString(run.elevationGainMeters, units: userProfile.unitPreference)
    }
    
    
}
