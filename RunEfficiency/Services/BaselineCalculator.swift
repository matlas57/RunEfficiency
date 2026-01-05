//
//  BaselineCalculator.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/30/25.
//

import Foundation

struct MetricBaseline {
    let mean: Double?
    let stdDev: Double?
    let sampleCount: Int
}

struct MechanicsBaselines {
    let verticalRatioBaseline: MetricBaseline?
    let groundContactTimeBaseline: MetricBaseline?
    let sampleCount: Int
}

enum BaselineState {
    case insufficientSamples(minRequired: Int, actual: Int)
    case established
}


final class BaselineCalculator {
    private let runRepository: any RunRepository
    
    init(runRepository: any RunRepository) {
        self.runRepository = runRepository
    }
    
    func fetchRuns() throws -> [Run] {
        let allRuns = try runRepository.fetchAllRuns()
        
        let baselineRuns = allRuns.filter { run in
            if run.averageGroundContactTime != nil && run.averageVerticalRatio != nil {
                return run.durationSeconds >= 600
            } else { return false }
        }
        
        return baselineRuns
    }
    
    func computeMechanicsScoreBaselines() -> MechanicsBaselines? {
        do {
            if
                let vrBaseline = try computeBaseline(for: \.averageVerticalRatio),
                let gctBaseline = try computeBaseline(for: \.averageGroundContactTime) {
                    let sampleCount = min(vrBaseline.sampleCount, gctBaseline.sampleCount)
                    return MechanicsBaselines(
                        verticalRatioBaseline: vrBaseline,
                        groundContactTimeBaseline: gctBaseline,
                        sampleCount: sampleCount
                    )
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    private func computeBaseline(for keyPath: KeyPath<Run, Double?>) throws -> MetricBaseline? {
          // get all runs from CoreData that conform to the baseline filter
          let runs = try fetchRuns()
          
          // Extract valid metric (non nil) values for the specific metric specified in keyPath
          let values = runs.compactMap { $0[keyPath: keyPath] }
          // Ensure there are engough runs to compute a baseline
          guard values.count >= 10 else { return nil }

          // Compute fields of MetricBaseline
          let mean = values.reduce(0, +) / Double(values.count)

          let variance = values.reduce(0) { partialResult, value in
              let diff = value - mean
              return partialResult + diff * diff
          } / Double(values.count)

          let stdDev = sqrt(variance)

          return MetricBaseline(mean: mean, stdDev: stdDev, sampleCount: values.count)
      }
    
    static func computeMechanicsScoreBaselines(from runs: [Run], minSampleCount: Int = 10) -> (baselines: MechanicsBaselines?, state: BaselineState) {
        let vrBaseline = computeBaseline(runs: runs, keyPath: \.averageVerticalRatio, minSampleCount: minSampleCount)
        let gctBaseline = computeBaseline(runs: runs, keyPath: \.averageGroundContactTime, minSampleCount: minSampleCount)
        let sampleCount = min(vrBaseline.sampleCount, gctBaseline.sampleCount)
        
        if sampleCount < minSampleCount {
            return (
                baselines: nil, 
                state: .insufficientSamples(minRequired: minSampleCount, actual: sampleCount)
            )
        } else {
            return (
                baselines: MechanicsBaselines(
                    verticalRatioBaseline: vrBaseline,
                    groundContactTimeBaseline: gctBaseline,
                    sampleCount: sampleCount
                ),
                state: .established
            )
        }
    }
    
    static func computeBaseline(runs: [Run], keyPath: KeyPath<Run, Double?>, minSampleCount: Int) -> MetricBaseline {
        
        let values = runs.compactMap { $0[keyPath: keyPath] }
        
        guard values.count >= minSampleCount else {
            return MetricBaseline (mean: nil, stdDev: nil, sampleCount: values.count)
        }
        
        let mean = values.reduce(0, +) / Double(values.count)
        
        let variance = values.reduce(0) { partialResult, value in
            let diff = value - mean
            return partialResult + diff * diff
        } / Double(values.count)

        let stdDev = sqrt(variance)

        return MetricBaseline(mean: mean, stdDev: stdDev, sampleCount: values.count)
    }
    
    
}
