//
//  RunsListView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct RunsListView: View {
    var runs: [Run]
    var userProfile: UserProfile
    
    var body: some View {
        VStack {
            Text("Recent Runs")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(runs) { run in
                NavigationLink {
                    RunDetailView(
                        viewModel: RunDetailViewModel(run: run, userProfile: userProfile),
                        run: run
                    )
                } label : {
                    RunRowView(run: run, userProfile: userProfile)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    RunsListView(runs: MockData.sampleRuns, userProfile: MockData.sampleUserProfile)
}
