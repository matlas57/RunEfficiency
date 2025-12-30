//
//  RunEntity+CoreDataProperties.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/29/25.
//
//

public import Foundation
public import CoreData


public typealias RunEntityCoreDataPropertiesSet = NSSet

extension RunEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RunEntity> {
        return NSFetchRequest<RunEntity>(entityName: "RunEntity")
    }

    @NSManaged public var averageCadence: Double
    @NSManaged public var averageGroundContactTime: Double
    @NSManaged public var averageHeartRate: Double
    @NSManaged public var averagePowerWatts: Double
    @NSManaged public var averageVerticalOscillation: Double
    @NSManaged public var distanceMeters: Double
    @NSManaged public var durationSeconds: Double
    @NSManaged public var elevationGainMeters: Double
    @NSManaged public var elevationLossMeters: Double
    @NSManaged public var id: UUID?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var shoeId: UUID?
    @NSManaged public var source: String?
    @NSManaged public var date: Date?
    @NSManaged public var externalActivityId: Int64
    @NSManaged public var calories: Double
    @NSManaged public var maxHeartRate: Double
    @NSManaged public var maxCadence: Double
    @NSManaged public var averageVerticalRatio: Double
    @NSManaged public var averageStrideLength: Double
    @NSManaged public var vO2Max: Double
    @NSManaged public var averageSpeedMetersPerSecond: Double
    @NSManaged public var hrTimeInZone_1: Double
    @NSManaged public var hrTimeInZone_2: Double
    @NSManaged public var hrTimeInZone_3: Double
    @NSManaged public var hrTimeInZone_4: Double
    @NSManaged public var hrTimeInZone_5: Double
}

extension RunEntity : Identifiable {

}
