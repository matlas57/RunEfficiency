//
//  GarminActivityImporter.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/16/25.
//

import Foundation

struct GarminActivityImporter {

    func importRun(from data: Data) throws -> Run? {
        let dto = try JSONDecoder().decode(GarminActivityDTO.self, from: data)

        // Only import running activities
        guard dto.activityType.typeKey.contains("running") else {
            return nil
        }

        // Skip if required fields are missing
        guard
            let distance = dto.distance,
            let date = GarminDateParser.formatter.date(from: dto.startTimeGMT)
        else {
            print("Skipping run due to missing data: \(dto.activityId)")
            return nil
        }

        return Run(
            id: UUID(),
            externalActivityId: dto.activityId,
            date: date,
            name: dto.activityName ?? "Run",
            distanceMeters: distance,
            durationSeconds: Int(dto.duration),
            elevationGainMeters: dto.elevationGain,
            averageHeartRate: dto.averageHR,
            maxHeartRate: dto.maxHR,
            averageCadence: dto.averageRunningCadenceInStepsPerMinute,
            averageStrideLength: nil
        )
    }

}
