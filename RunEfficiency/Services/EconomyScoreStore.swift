//
//  EconomyScoreStore.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 1/5/26.
//

import Foundation
import Combine



@MainActor
final class EconomyScoreStore: ObservableObject {
    @Published private(set) var scores: [UUID: RunningEconomyScore] = [:]
    @Published private(set) var baselineState: BaselineState?
    
    func recompute(with runs: [Run]) {
        //try to compute baseline
        let minSampleCount = 10
        let (mechanicsBaselines, baselineState) = BaselineCalculator.computeMechanicsScoreBaselines(from: runs, minSampleCount: minSampleCount)
        self.baselineState = baselineState
        
        var newScores: [UUID: RunningEconomyScore] = [:]

        for run in runs {
            let componentScores = RunningEconomyCalculator.computeEconomyScores(
                for: run,
                mechanicBaselines: mechanicsBaselines
            )

            // Extract components
            let cardio = componentScores[EconomyComponentIndex.cardio.rawValue]
            let mechanics = componentScores[EconomyComponentIndex.mechanics.rawValue]
            let power = componentScores[EconomyComponentIndex.power.rawValue]
            let terrain = componentScores[EconomyComponentIndex.terrain.rawValue]

            // Aggregate overall score
            let overall = (
                cardio.score +
                mechanics.score +
                power.score +
                terrain.score
            ) / 4.0

            // Build domain results
            let result = RunningEconomyScore(
                runId: run.id,
                overallScore: overall,
                cardioScore: ComponentScore(score: cardio.score, usesBaseline: cardio.usesBaseline),
                mechanicsScore: ComponentScore(score: mechanics.score, usesBaseline: mechanics.usesBaseline),
                powerScore: ComponentScore(score: power.score, usesBaseline: power.usesBaseline),
                terrainScore: ComponentScore(score: terrain.score, usesBaseline: terrain.usesBaseline),
            )

            newScores[run.id] = result
        }

        // Publish atomically
        self.scores = newScores

    }
    
    func score(for run: Run) -> RunningEconomyScore? {
        return nil
    }
    
    enum EconomyComponentIndex: Int {
        case cardio = 0
        case mechanics = 1
        case power = 2
        case terrain = 3
    }
}


