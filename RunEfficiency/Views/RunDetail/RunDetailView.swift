//
//  RunDetailView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct RunDetailView: View {
    @StateObject var viewModel: RunDetailViewModel
    
    var run: Run
    var body: some View {
        ScrollView {
            Text(String(run.name))
                .font(.largeTitle)
                .padding(.top)
            Text(viewModel.dateString)
                .font(.subheadline)
                .padding(.bottom)
                
            VStack {
                StatRow(statName: "Distance", statValueString: viewModel.distanceString)
                StatRow(statName: "Pace", statValueString: viewModel.paceString)
                StatRow(statName: "Elevation Gain", statValueString: viewModel.elevationGainString)
            }
            .padding(.horizontal, 65)
            
            VStack {
                Text(String(abs(viewModel.economyScore.rounded())))
                    .font(.system(size: 96, weight: .black))
                Text("Economy Score")
            }
            .padding(.vertical)
            Spacer()
        }
    }
}

#Preview {
    let sampleRun = MockData.sampleRuns.first!
    let profile = UserProfile(unitPreference: .metric)

    let vm = RunDetailViewModel(
        run: sampleRun,
        userProfile: profile
    )
    
    RunDetailView(viewModel: vm, run: sampleRun)
}
