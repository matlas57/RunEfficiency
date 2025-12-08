//
//  ProfileHost.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/8/25.
//

import SwiftUI

struct ProfileHost: View {
    @EnvironmentObject var userProfileStore: UserProfileStore
    
    
    var body: some View {
        Text("User Profile")
            .font(.title)
        VStack(alignment: .center) {
            HStack {
                Text("Unit Preference:")
                BasicDropdownMenu(
                    options: UnitPreference.allCases,
                    selection: $userProfileStore.profile.unitPreference
                )
            }
        }
        .padding()
        .background(.tertiary.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    ProfileHost()
        .environmentObject(UserProfileStore())
}
