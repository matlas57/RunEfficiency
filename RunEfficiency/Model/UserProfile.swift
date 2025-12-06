//
//  UserProfile.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/6/25.
//

import Foundation

enum UnitPreference: String, Codable {
    case metric
    case imperial
}

struct UserProfile: Codable, Hashable, Identifiable {
    var id = UUID()
    var unitPrefernce: UnitPreference
    
    init(unitPrefernce: UnitPreference = .metric) {
        self.unitPrefernce = unitPrefernce
    }
}
