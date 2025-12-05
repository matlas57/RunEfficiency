//
//  RunningEconomyPoint.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import Foundation

struct RunningEconomyPoint: Hashable, Identifiable {
    var id = UUID()
    var date: Date
    var efficiencyScore: Double
}
