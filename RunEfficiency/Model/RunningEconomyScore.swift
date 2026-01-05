//
//  RunningEconomyScore.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 1/5/26.
//

import Foundation

struct RunningEconomyScore {
    
    let runId: UUID
    
    let overallScore: Double
    
    let cardioScore: ComponentScore
    let mechanicsScore: ComponentScore
    let powerScore: ComponentScore
    let terrainScore: ComponentScore
}
