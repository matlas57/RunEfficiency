//
//  RunningEconomyCalculator.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/6/25.
//

import Foundation

struct RunningEconomyCalculator {
    static func computeEconomyScore(for run: Run) -> Double {
         // Example placeholder:
         let pace = run.paceSecondsPerKm   // raw pace in minutes per mile
         let hr = run.averageHeartRate
         let cadence = run.averageCadence

         // Very fake sample formula (you'll replace it later):
         return (cadence! / pace) - (hr! / 200.0)
    }
}
