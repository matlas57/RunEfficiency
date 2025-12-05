//
//  MockData.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import Foundation

struct MockData {

    static let sampleRuns: [Run] = [
        Run(
            id: UUID(),
            name: "Easy Run",
            distance: 4.2,
            date: Date().addingTimeInterval(-86400 * 1),
            elevationGain: 120,
            averageHeartRate: 142,
            averageCadence: 165,
            averageStrideLength: 1.1
        ),
        Run(
            id: UUID(),
            name: "Long Run",
            distance: 10.5,
            date: Date().addingTimeInterval(-86400 * 3),
            elevationGain: 450,
            averageHeartRate: 150,
            averageCadence: 170,
            averageStrideLength: 1.2
        ),
        Run(
            id: UUID(),
            name: "Tempo Run",
            distance: 6.0,
            date: Date().addingTimeInterval(-86400 * 5),
            elevationGain: 200,
            averageHeartRate: 162,
            averageCadence: 178,
            averageStrideLength: 1.25
        )
    ]
}

