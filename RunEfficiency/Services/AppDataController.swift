//
//  AppDataController.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 1/6/26.
//

import Foundation
import Combine

final class AppDataController: ObservableObject {

    // MARK: - Lifecycle

    enum State {
        case idle
        case bootstrapping
        case ready
        case failed(Error)
    }

    private(set) var state: State = .idle

    // MARK: - Dependencies

    private let runRepository: any RunRepository
    private let batchImporter = GarminBatchImporter()
    private let jsonRepo = JSONRunRepository(loader: GarminBatchImporter())

    let economyScoreStore: EconomyScoreStore

    // MARK: - Bootstrap Guard

    private var hasBootstrapped = false

    // MARK: - Init

    init(
        runRepository: any RunRepository,
        economyScoreStore: EconomyScoreStore
    ) {
        self.runRepository = runRepository
        self.economyScoreStore = economyScoreStore
    }

    // MARK: - Bootstrap (Write Boundary)

    func bootstrapIfNeeded() {
        guard !hasBootstrapped else { return }

        hasBootstrapped = true
        state = .bootstrapping

        do {
            // 1. Import runs (idempotent by repository guarantees)
            let runs = try jsonRepo
                .fetchAllRuns()
                .sorted { $0.date > $1.date }

            for run in runs {
                try runRepository.save(run: run)
            }

            // 2. Compute derived data
            economyScoreStore.recompute(with: runs)

            state = .ready
        } catch {
            state = .failed(error)
            assertionFailure("AppDataController bootstrap failed: \(error)")
        }
    }
    
    func savePreviewRuns(_ runs: [Run]) {
        for run in runs {
            try? runRepository.save(run: run)
        }
        economyScoreStore.recompute(with: runs)
        hasBootstrapped = true
        state = .ready
    }

    // MARK: - Read Boundary

    func fetchRuns() throws -> [Run] {
        guard case .ready = state else {
            assertionFailure("Attempted to read runs before AppDataController was ready")
            return []
        }
        return try runRepository.fetchAllRuns()
    }
}
