//
//  RunningEconomyCalculator.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/6/25.
//

import Foundation

struct RunningEconomyCalculator {
    static func computeEconomyScores(for run: Run) -> [Double] {
        var componentScores: [Double] = []
        
        if let cardioScore = cardioEfficiencyScore(for: run), cardioScore > 0 {
            componentScores.append(normalize(raw: cardioScore, lowerBound: 1.0, upperBound: 6.0))
        } else {
            componentScores.append(0.0)
        }
        
        if let mechanicsScore = mechanicsEfficiencyScore(for: run), mechanicsScore > 0 {
            componentScores.append(normalize(raw: mechanicsScore, lowerBound: 0.0, upperBound: 1.0))
        } else {
            componentScores.append(0.0)
        }
        
        if let powerScore = powerEfficiencyScore(for: run), powerScore > 0 {
            componentScores.append(normalize(raw: powerScore, lowerBound: 0.0, upperBound: 100.0))
        } else {
            componentScores.append(0.0)
        }
        
        if let terrainScore = terrainEfficiencyScore(for: run), terrainScore > 0 {
            componentScores.append(normalize(raw: terrainScore, lowerBound: 0.0, upperBound: 1.0))
        } else {
            componentScores.append(0.0)
        }
        
        return componentScores
    }
    
    static func computeEconomyScore(for run: Run) -> Double {
        let componentScores = computeEconomyScores(for: run)
        guard !componentScores.isEmpty else { return 0.0 }
        let nonZero = componentScores.count { $0 != 0.0 }
        return componentScores.reduce(0, +) / Double(nonZero)
    }
    
    private static func cardioEfficiencyScore(for run: Run) -> Double? {
        guard run.distanceMeters > 0,
              run.durationSeconds > 0
        else {
            return nil
        }

        guard let effort = zoneWeightedEffort(for: run) else {
            return nil
        }

        let speed = run.distanceMeters / Double(run.durationSeconds)

        return speed / effort
    }
    
    private static func zoneWeightedEffort(for run: Run) -> Double? {
        // Handle optional type hrTimeInZones
        guard let hrTimeInZones = run.hrTimeInZones,
              !hrTimeInZones.isEmpty
        else {
            return nil
        }

        let zoneWeights: [Int: Double] = [
            1: 0.6,
            2: 0.75,
            3: 0.9,
            4: 1.05,
            5: 1.2
        ]

        let totalTime = hrTimeInZones.values.reduce(0, +)
        guard totalTime > 0 else { return nil }

        var weightedSum: Double = 0

        for (zone, time) in hrTimeInZones {
            guard let weight = zoneWeights[zone] else { continue }
            weightedSum += time * weight
        }

        return weightedSum / totalTime
    }
    
    private static func mechanicsEfficiencyScore(for run: Run) -> Double? {
        var penalties: [Double] = []
        
        if let verticalRatio = run.averageVerticalRatio {
            penalties.append(mechanicPenalty(mechanicValue: verticalRatio, ideal: 7.0, maxThreshold: 12.0))
        }
        
        if let gct = run.averageGroundContactTime {
            penalties.append(mechanicPenalty(mechanicValue: gct, ideal: 220.0, maxThreshold: 300.0))
        }
        
        guard !penalties.isEmpty else { return nil }
        
        let avgPenalty = penalties.reduce(0, +) / Double(penalties.count)
        return 1.0 / avgPenalty
    }
    
    private static func mechanicPenalty(mechanicValue: Double, ideal: Double, maxThreshold: Double) -> Double {
        let diff = max(0, mechanicValue - ideal)
        
        return 1.0 + pow(diff / (maxThreshold - ideal), 2)
    }
    
    private static func powerEfficiencyScore(for run: Run) -> Double? {
        var metricScores: [Double] = []
        
        if let stride = run.averageStrideLength {
            metricScores.append(normalize(raw: stride, lowerBound: 0.9, upperBound: 1.5))
        }
        
        if let cadence = run.averageCadence {
            metricScores.append(normalize(raw: cadence, lowerBound: 150, upperBound: 190))
        }
        
        if let power = run.averagePowerWatts {
            metricScores.append(normalize(raw: power, lowerBound: 200, upperBound: 400))
        }
        
        // If no metrics available, return 0
        guard !metricScores.isEmpty else { return 0 }

        // Average the normalized scores
        return metricScores.reduce(0, +) / Double(metricScores.count)
    }
    
    private static func terrainEfficiencyScore(for run: Run) -> Double? {
        guard let elevationGain = run.elevationGainMeters,
              let elevationLoss = run.elevationLossMeters,
              let gct = run.averageGroundContactTime,
              let vo = run.averageVerticalOscillation,
              run.distanceMeters > 0
        else { return nil }

        // normalize each metric 0-1 (0=bad, 1=good)
        let gainScore = max(0.0, 1.0 - min(elevationGain / 50.0, 1.0)) // higher gain = lower score
        let lossScore = max(0.0, 1.0 - min(elevationLoss / 50.0, 1.0)) // higher loss = lower score
        let gctScore = max(0.0, 1.0 - min(gct / 400.0, 1.0)) // higher GCT = lower score
        let voScore = max(0.0, 1.0 - min(vo / 15.0, 1.0))   // higher VO = lower score

        // weighted sum
        return 0.25 * gainScore + 0.25 * lossScore + 0.25 * gctScore + 0.25 * voScore
    }

    
    private static func normalize(raw: Double, lowerBound: Double, upperBound: Double) -> Double {
        guard upperBound > lowerBound else { return 0 }
        
        let clamped = Swift.min(Swift.max(raw, lowerBound), upperBound)
        let normalized = (clamped - lowerBound) / (upperBound - lowerBound)
        
        return normalized * 100.0
    }

}
