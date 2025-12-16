//
//  Run.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import Foundation

struct Run: Codable, Hashable, Identifiable {
    var id = UUID() //UUID is safer since Garmin runs are not guaranteed to be sequential integers
    var externalActivityId: Int
    var date: Date
    var name: String
    var distanceMeters: Double
    var durationSeconds: Int
    
    var elevationGainMeters: Double?
    var elevationLossMeters: Double?
    
    var calories: Double?
    var averageHeartRate: Double?
    var maxHeartRate: Double?
    
    var averageCadence: Double?
    var maxCadence: Double?
    
    var averagePowerWatts: Double?
    var averageVerticalOscillation: Double?
    var averageGroundContactTime: Double?
    var averageStrideLength: Double?
    var vO2Max: Double?
    var averageVerticalRatio: Double?
    
    var averageSpeedMetersPerSecond: Double?
    
    // Computed raw values that do NOT depend on units or formatting
    var paceSecondsPerKm: Double {
        distanceMeters > 0 ? Double(durationSeconds) / (distanceMeters / 1000.0) : 0
    }
    
    var paceSecondsPerMile: Double {
        distanceMeters > 0 ? Double(durationSeconds) / (distanceMeters / 1609.34) : 0
    }
}
