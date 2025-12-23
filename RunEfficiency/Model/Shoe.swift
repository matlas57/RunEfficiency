//
//  Shoe.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/23/25.
//

import Foundation

struct Shoe: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var brand: String?
    var notes: String?
    
    //Shoe specs
    var stackHeightMm: Double?
    var dropMm: Double?
    var hasCarbonPlate: Bool?
}
