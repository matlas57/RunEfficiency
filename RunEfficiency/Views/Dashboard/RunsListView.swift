//
//  RunsListView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct RunsListView: View {
    @EnvironmentObject var userProfileStore: UserProfileStore

    var runs: [Run]
    
    var body: some View {
        VStack {
            Text("Recent Runs")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(runs) { run in
                NavigationLink {
                    RunDetailView(
                        viewModel: RunDetailViewModel(run: run, userProfile: userProfileStore.profile),
                        run: run
                    )
                } label : {
                    RunRowView(run: run)
                        .environmentObject(userProfileStore)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    RunsListView(runs: MockData.sampleRuns)
}
