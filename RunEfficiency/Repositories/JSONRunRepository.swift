//
//  JSONRunRepository.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/29/25.
//

import Foundation
import Combine

final class JSONRunRepository: RunRepository, ObservableObject {

    private let loader: GarminBatchImporter

    init(loader: GarminBatchImporter) {
        self.loader = loader
    }

    func fetchAllRuns() throws -> [Run] {
        try loader.importRunsFromBundle()
    }

    func fetchRuns(since date: Date) throws -> [Run] {
        try loader
            .importRunsFromBundle()
            .filter { $0.date > date }
    }

    func save(run: Run) throws {
        // JSON is read-only for now
    }

    func delete(runId: UUID) throws {
        // JSON is read-only for now
    }
}
