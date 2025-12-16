//
//  GarminActivityImporter.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/16/25.
//

import Foundation

struct GarminActivityImporter {

    func importRun(from data: Data) throws -> Run {
        let dto = try JSONDecoder().decode(GarminActivityDTO.self, from: data)

        guard dto.activityType.typeKey == "running" else {
            throw ImportError.notARun
        }

        guard let date = GarminDateParser.formatter.date(from: dto.startTimeGMT) else {
            throw ImportError.invalidDate
        }

        return Run(
            id: UUID(),
            externalActivityId: dto.activityId,
            date: date,
            name: dto.activityName ?? "Run",
            distanceMeters: dto.distance,
            durationSeconds: Int(dto.duration),
            elevationGainMeters: dto.elevationGain,
            averageHeartRate: dto.averageHR,
            maxHeartRate: dto.maxHR,
            averageCadence: dto.averageRunningCadenceInStepsPerMinute,
            averageStrideLength: nil
        )
    }
}
