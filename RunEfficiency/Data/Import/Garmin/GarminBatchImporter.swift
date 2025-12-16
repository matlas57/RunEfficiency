//
//  GarminBatchImporter.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/16/25.
//

import Foundation

struct GarminBatchImporter {

    let importer = GarminActivityImporter()

    func importRunsFromBundle() throws-> [Run] {
        // Get all JSON URLs from the bundle
        guard let urls = Bundle.main.urls(forResourcesWithExtension: "json", subdirectory: nil) else {
            return []
        }

        // Filter only activity JSON files
        let activityFiles = urls.filter { $0.lastPathComponent.hasPrefix("activity_") }

        // Import runs safely
        var runs: [Run] = []

        for url in activityFiles {
            do {
                let data = try Data(contentsOf: url)
                // importRun may throw or return nil
                if let run = try? importer.importRun(from: data) {
                    runs.append(run)
                }
            } catch ImportError.notARun {
                // skip non-running activities
                continue
            } catch {
                // log other errors but continue
                throw NSError(
                    domain: "GarminBatchImporter",
                    code: 1,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Error importing file \(url.lastPathComponent): \(error)"
                    ]
                )
            }
        }

        // Sort newest to oldest
        return runs.sorted { $0.date > $1.date }
    }
}
