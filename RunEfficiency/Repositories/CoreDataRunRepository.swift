//
//  CoreDataRunRepository.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/29/25.
//

import Foundation
import CoreData

final class CoreDataRunRepository: RunRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    // MARK: - Reads
    // Read all from DB
    func fetchAllRuns() throws -> [Run] {
        let request: NSFetchRequest<RunEntity> = RunEntity.fetchRequest()
        let entities = try context.fetch(request)
        return entities.map { $0.toRun() }
    }

    // Read all since date
    func fetchRuns(since date: Date) throws -> [Run] {
        let request: NSFetchRequest<RunEntity> = RunEntity.fetchRequest()
        request.predicate = NSPredicate(format: "startDate > %@", date as NSDate)
        let entities = try context.fetch(request)
        return entities.map { $0.toRun() }
    }

    // MARK: - Writes
    // Add a new run
    func save(run: Run) throws {
        let entity = RunEntity(context: context)
        entity.update(from: run)
//        try context.save()
        do {
            try context.save()
        } catch {
            print("❌ Core Data save failed:", error)
            fatalError()
        }
    }

    // Delete a run by id
    func delete(runId: UUID) throws {
        let request: NSFetchRequest<RunEntity> = RunEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", runId as CVarArg)

        let results = try context.fetch(request)
        results.forEach { context.delete($0) }

        try context.save()
    }
    
    func deleteAllRuns() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = RunEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        deleteRequest.resultType = .resultTypeObjectIDs

        let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
        let objectIDs = result?.result as? [NSManagedObjectID] ?? []

        NSManagedObjectContext.mergeChanges(
            fromRemoteContextSave: [NSDeletedObjectsKey: objectIDs],
            into: [context]
        )
    }
}
