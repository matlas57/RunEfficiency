//
//  RunsListView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct RunsListView: View {
    @EnvironmentObject var userProfileStore: UserProfileStore
    @EnvironmentObject var shoeStore: ShoeStore

    @State var runs: [Run]
    
    var body: some View {
        VStack {
            Text("Recent Runs")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(runs.indices, id: \.self) { index in
                NavigationLink {
                    RunDetailView(
                        viewModel: RunDetailViewModel(
                            run: runs[index],
                            userProfile: userProfileStore.profile,
                            shoeStore: shoeStore,
                            onUpdate: { updatedRun in
                                runs[index] = updatedRun
                            }
                        ),
                        run: $runs[index],
                    )
                    .environmentObject(shoeStore)
                } label : {
                    RunRowView(run: $runs[index])
                        .environmentObject(userProfileStore)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
