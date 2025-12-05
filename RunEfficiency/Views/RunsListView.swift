//
//  RunsListView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct RunsListView: View {
    var runs: [Run]
    
    var body: some View {
        VStack {
            Text("Recent Runs")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(runs) { run in
                NavigationLink {
                    RunDetailView(run: run)
                } label : {
                    RunRowView(run: run)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    RunsListView(runs: MockData.sampleRuns)
}
