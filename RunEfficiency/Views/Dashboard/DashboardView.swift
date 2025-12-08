//
//  DashboardView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    TrendView(points: viewModel.points)
                    RunsListView(runs: viewModel.runs, userProfile: viewModel.userProfile)
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
}
