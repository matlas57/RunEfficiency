//
//  ProfileHost.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/8/25.
//

import SwiftUI

struct ProfileHost: View {
    @EnvironmentObject var userProfileStore: UserProfileStore
    @EnvironmentObject var shoeStore: ShoeStore
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Units")
                            .font(.headline)

                        BasicDropdownMenu(
                            options: UnitPreference.allCases,
                            selection: $userProfileStore.profile.unitPreference
                        )
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.secondary.opacity(0.08))
                    .cornerRadius(12)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Shoe Library")
                            .font(.headline)

                        ShoeLibrary()
                            .environmentObject(shoeStore)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.secondary.opacity(0.08))
                    .cornerRadius(12)

                }
                .padding()
            }
            .navigationTitle("Profile")
        }
    }


}

#Preview {
    ProfileHost()
        .environmentObject(UserProfileStore())
        .environmentObject(ShoeStore())
}
