//
//  GarminActivityDTO.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/16/25.
//

import Foundation

struct GarminActivityDTO: Decodable {
    let activityId: Int
    let activityName: String?
    let startTimeGMT: String
    let duration: Double
    let distance: Double?
    let elevationGain: Double?
    let elevationLoss: Double?
    let averageHR: Double?
    let maxHR: Double?
    let avgStrideLength: Double? 
    let averageRunningCadenceInStepsPerMinute: Double?
    let maxRunningCadenceInStepsPerMinute: Double?
    let avgPower: Double?
    let avgVerticalOscillation: Double?
    var avgGroundContactTime: Double?
    var vO2MaxValue: Double?
    var avgVerticalRatio: Double?
    
    var hrTimeInZone_1: Double?
    var hrTimeInZone_2: Double?
    var hrTimeInZone_3: Double?
    var hrTimeInZone_4: Double?
    var hrTimeInZone_5: Double?
    
    var hrTimeInZones: [Int: Double] {
        [
            1: hrTimeInZone_1,
            2: hrTimeInZone_2,
            3: hrTimeInZone_3,
            4: hrTimeInZone_4,
            5: hrTimeInZone_5
        ].compactMapValues { $0 }
    }

    let activityType: ActivityTypeDTO

    struct ActivityTypeDTO: Decodable {
        let typeKey: String
    }
}
