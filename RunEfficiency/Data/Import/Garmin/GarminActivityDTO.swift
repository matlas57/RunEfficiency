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
    let distance: Double
    let elevationGain: Double?
    let averageHR: Double?
    let maxHR: Double?
    let averageRunningCadenceInStepsPerMinute: Double?

    let activityType: ActivityTypeDTO

    struct ActivityTypeDTO: Decodable {
        let typeKey: String
    }
}
