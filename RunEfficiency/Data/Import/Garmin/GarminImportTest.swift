//
//  GarminImportTest.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/16/25.
//

import Foundation

enum GarminImportTest {

    static func runSingleActivityTest() {
        guard let url = Bundle.main.url(
            forResource: "activity_21263083277",
            withExtension: "json"
        ) else {
            print("❌ Could not find activity JSON in bundle")
            return
        }

        do {
            let data = try Data(contentsOf: url)

            let importer = GarminActivityImporter()
            let run = try importer.importRun(from: data)

            print("✅ Successfully imported Run")
            print("Name:", run.name)
            print("Date:", run.date)
            print("Distance (m):", run.distanceMeters)
            print("Duration (s):", run.durationSeconds)
            print("External ID:", run.externalActivityId)

        } catch ImportError.notARun {
            print("⚠️ Activity is not a run")

        } catch ImportError.invalidDate {
            print("❌ Invalid date format in Garmin data")

        } catch {
            print("❌ Unexpected import error:", error)
        }
    }
}
