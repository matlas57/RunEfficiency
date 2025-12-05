//
//  Run.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import Foundation

struct Run: Codable, Hashable, Identifiable {
    var id = UUID() //UUID is safer since Garmin runs are not guaranteed to be sequential integers
    var name: String
    var distance: Double
    var date: Date
    var elevationGain: Double
    var averageHeartRate: Double?
    var averageCadence: Double?
    var averageStrideLength: Double?
    
    static var lengthFormatter = LengthFormatter()
    
    // use a formatter to make a String with the distance and its unit
    var distanceString: String {
        Run.lengthFormatter
            .string(fromValue: distance, unit: .mile)
    }
    
    var dateString: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    var efficiencyScore: Double {
        // TODO: Implement a real formula for the score
        // Safely handle optionals by averaging only available values
        var sum: Double = 0
        if let cadence = averageCadence {
            sum += cadence
        }
        if let stride = averageStrideLength {
            sum += stride
        }
        return sum / 2 
    }
}
