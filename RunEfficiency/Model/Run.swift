//
//  Run.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import Foundation

struct Run: Codable, Hashable, Identifiable {
    var id = UUID() //UUID is safer since Garmin runs are not guaranteed to be sequential integers
    var date: Date
    var name: String
    var distanceMeters: Double
    var durationSeconds: Int
    var elevationGainMeters: Double?
    var averageHeartRate: Double?
    var maxHeartRate: Int?
    var averageCadence: Double?
    var averageStrideLength: Double?
    
    // Computed raw values that do NOT depend on units or formatting
    var paceSecondsPerKm: Double {
        distanceMeters > 0 ? Double(durationSeconds) / (distanceMeters / 1000.0) : 0
    }
    
    var paceSecondsPerMile: Double {
        distanceMeters > 0 ? Double(durationSeconds) / (distanceMeters / 1609.34) : 0
    }
}
