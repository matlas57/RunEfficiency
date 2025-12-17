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
    var elevationLossString = ""
    var avgHRString = ""
    var maxHRString = ""
    var strideLengthString = ""
    var cadenceString = ""
    var powerString = ""
    var verticalOscillationString = ""
    var verticalRatioString = ""
    var groundContactTimeString = ""
    var effortZoneString = ""
    
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
        self.elevationLossString = RunFormatter.shared.elevationString(run.elevationLossMeters, units: userProfile.unitPreference)
        self.avgHRString = RunFormatter.shared.heartRateString(run.averageHeartRate)
        self.maxHRString = RunFormatter.shared.heartRateString(run.maxHeartRate)
        self.strideLengthString = RunFormatter.shared.strideLengthString( run.averageStrideLength, units: userProfile.unitPreference)
        self.cadenceString = RunFormatter.shared.cadenceString(run.averageCadence)
        self.powerString = RunFormatter.shared.powerString(run.averagePowerWatts)
        self.verticalOscillationString = RunFormatter.shared.verticalOscillationString(run.averageVerticalOscillation, units: userProfile.unitPreference)
        self.verticalRatioString = RunFormatter.shared.verticalRatioString(run.averageVerticalRatio)
        self.groundContactTimeString = RunFormatter.shared.groundContactTimeString(run.averageGroundContactTime)
        self.effortZoneString = RunFormatter.shared.effortZoneString(run.effortZone)
    }
    
    
}
