//
//  UserProfileStore.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/8/25.
//

import Foundation
import Combine

class UserProfileStore: ObservableObject {
    @Published var profile: UserProfile

    init(profile: UserProfile = UserProfile(unitPreference: .imperial)) {
        self.profile = profile
    }
}
