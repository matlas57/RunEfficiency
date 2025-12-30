//
//  RunRepository.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/29/25.
//

import Foundation

protocol RunRepository: ObservableObject {
    /// Source of truth for reading runs
    func fetchAllRuns() throws -> [Run]

    /// Future-proof for incremental sync
    func fetchRuns(since date: Date) throws -> [Run]

    /// Write-through API (no-op for JSON)
    func save(run: Run) throws

    func delete(runId: UUID) throws
}
