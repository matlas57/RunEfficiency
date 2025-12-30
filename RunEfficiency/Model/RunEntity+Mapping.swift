//
//  RunEntity+Mapping.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/29/25.
//

import Foundation

extension RunEntity {

    // MARK: - Update Core Data from Run

    func update(from run: Run) {
        // Required fields — fail-safe defaults
        self.id = run.id
        self.externalActivityId = Int64(run.externalActivityId)
        self.date = run.date
        self.source = run.name
        self.distanceMeters = run.distanceMeters
        self.durationSeconds = Double(run.durationSeconds)

        // Optional elevation
        self.elevationGainMeters = run.elevationGainMeters ?? 0.0
        self.elevationLossMeters = run.elevationLossMeters ?? 0.0

        // Optional energy / HR
        self.calories = run.calories ?? 0.0
        self.averageHeartRate = run.averageHeartRate ?? 0.0
        self.maxHeartRate = run.maxHeartRate ?? 0.0

        // Optional cadence
        self.averageCadence = run.averageCadence ?? 0.0
        self.maxCadence = run.maxCadence ?? 0.0

        // Optional running dynamics
        self.averagePowerWatts = run.averagePowerWatts ?? 0.0
        self.averageVerticalOscillation = run.averageVerticalOscillation ?? 0.0
        self.averageGroundContactTime = run.averageGroundContactTime ?? 0.0
        self.averageStrideLength = run.averageStrideLength ?? 0.0
        self.averageVerticalRatio = run.averageVerticalRatio ?? 0.0

        // Optional physiology
        self.vO2Max = run.vO2Max ?? 0.0

        // Optional derived metrics
        self.averageSpeedMetersPerSecond = run.averageSpeedMetersPerSecond ?? 0.0

        // Optional relationship key
        self.shoeId = run.shoeId
    }

    // MARK: - Convert Core Data → Run

    func toRun() -> Run {
        Run(
            id: id ?? UUID(),  // defensive, should never be nil
            externalActivityId: Int(externalActivityId),
            date: date ?? Date(),
            name: source ?? "Unnamed Run",
            distanceMeters: distanceMeters,
            durationSeconds: Int(durationSeconds),

            elevationGainMeters: elevationGainMeters,
            elevationLossMeters: elevationLossMeters,

            calories: calories,
            averageHeartRate: averageHeartRate,
            maxHeartRate: maxHeartRate,

            averageCadence: averageCadence,
            maxCadence: maxCadence,

            averagePowerWatts: averagePowerWatts,
            averageVerticalOscillation: averageVerticalOscillation,
            averageGroundContactTime: averageGroundContactTime,
            averageStrideLength: averageStrideLength,
            vO2Max: vO2Max,
            averageVerticalRatio: averageVerticalRatio,

            averageSpeedMetersPerSecond: averageSpeedMetersPerSecond,

            shoeId: shoeId,
            
            hrTimeInZones: [
                1: hrTimeInZone_1,
                2: hrTimeInZone_2,
                3: hrTimeInZone_3,
                4: hrTimeInZone_4,
                5: hrTimeInZone_5
            ]
            
        )
    }
}
