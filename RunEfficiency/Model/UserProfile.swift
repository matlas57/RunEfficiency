//
//  UserProfile.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/6/25.
//

import Foundation

enum UnitPreference: String, Codable, CaseIterable {
    case metric
    case imperial
}

extension UnitPreference: CustomStringConvertible {
    var description: String {
        switch self {
        case .metric: return "Metric"
        case .imperial: return "Imperial"
        }
    }
}

struct UserProfile: Codable, Hashable, Identifiable {
    var id = UUID()
    var unitPreference: UnitPreference
    
    init(unitPreference: UnitPreference = .metric) {
        self.unitPreference = unitPreference
    }
}
