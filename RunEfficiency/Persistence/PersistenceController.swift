//
//  PersistenceController.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/29/25.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static let preview: PersistenceController = {
        PersistenceController(inMemory: true)
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RunningEconomyModel")

        let description = NSPersistentStoreDescription()

        if inMemory {
            description.type = NSInMemoryStoreType
        } else {
            description.shouldMigrateStoreAutomatically = true
            description.shouldInferMappingModelAutomatically = true
        }

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Unresolved Core Data error \(error)")
            }
        }

        let context = container.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
    }
}

