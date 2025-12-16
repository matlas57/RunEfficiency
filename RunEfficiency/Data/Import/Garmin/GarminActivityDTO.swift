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

    let activityType: ActivityTypeDTO

    struct ActivityTypeDTO: Decodable {
        let typeKey: String
    }
}
