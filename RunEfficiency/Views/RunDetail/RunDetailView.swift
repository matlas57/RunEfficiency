//
//  RunDetailView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct RunDetailView: View {
    @StateObject var viewModel: RunDetailViewModel
    @EnvironmentObject var shoeStore: ShoeStore
    
    @Binding var run: Run
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
                StatRow(statName: "Effort", statValueString: viewModel.effortZoneString)
                StatRow(statName: "Avg Heart Rate", statValueString: String(viewModel.avgHRString))
                StatRow(statName: "Elevation Gain", statValueString: viewModel.elevationGainString)
            }
            .padding(.horizontal, 65)
            
            VStack {
                Text(String(format: "%.1f", abs(viewModel.economyScore)))
                    .font(.system(size: 96, weight: .black))
                Text("Economy Score")
            }
            .padding(.vertical)
            
            Divider()
                .padding(.horizontal)
            Text("Economy Components")
                .font(.title2)
            VStack {
                ScoreBar(scoreName: "Cardio", score: viewModel.economyComponentScores[0])
                Divider()
                    .padding(.horizontal)
                ScoreBar(scoreName: "Mechanics", score: viewModel.economyComponentScores[1])
                Divider()
                    .padding(.horizontal)
                ScoreBar(scoreName: "Power", score: viewModel.economyComponentScores[2])
                Divider()
                    .padding(.horizontal)
                ScoreBar(scoreName: "Terrain", score: viewModel.economyComponentScores[3])
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            Divider()
                .padding(.horizontal)
            Text("Running Dynamics")
                .font(.title2)
                .padding(.bottom)
            VStack {
                StatRow(statName: "Stride Length", statValueString: String(viewModel.strideLengthString))
                StatRow(statName: "Cadence", statValueString: String(viewModel.cadenceString))
                StatRow(statName: "Power", statValueString: String(viewModel.powerString))
                StatRow(statName: "Vertical Oscillation", statValueString: String(viewModel.verticalOscillationString))
                StatRow(statName: "Vertical Ratio", statValueString: String(viewModel.verticalRatioString))
                StatRow(statName: "Ground Contact Time", statValueString: String(viewModel.groundContactTimeString))
            }
            .padding(.horizontal, 50)
            .padding(.bottom)
            Divider()
                .padding(.horizontal)
            Text("Shoe")
                .font(.title2)
                .padding(.bottom)
            VStack(alignment: .center) {
                if let shoe = viewModel.shoeStore.getShoe(for: viewModel.run.shoeId) {
                    ShoeRecord(shoe: shoe)
                }
                Menu {
                    ForEach(viewModel.shoeStore.shoes) { shoe in
                        Button(shoe.name) {
                            viewModel.updateShoe(to: shoe)
                        }
                    }
                } label: {
                    HStack {
                        Text(viewModel.selectedShoe != nil ? "Change Shoe" : "Select a Shoe")
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                    .padding(.horizontal, 60)
                    .padding(.bottom)
                    .background(.tertiary.opacity(0.1))
                    .cornerRadius(8)
                }
                Text("More shoes can be added in the user profile menu")
                    .padding(.horizontal)
                    .padding(.bottom, 80)
            }
        }
    }
}

#Preview {
    let sampleRun: Run = {
    guard let url = Bundle.main.url(forResource: "activity_21263083277", withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let run = try? GarminActivityImporter().importRun(from: data) else {
            // fallback dummy run if import fails
            return Run(
                id: UUID(),
                externalActivityId: 0,
                date: Date(),
                name: "Sample Run",
                distanceMeters: 5000,
                durationSeconds: 1500,
                elevationGainMeters: 50,
                averageHeartRate: 150,
                maxHeartRate: 170,
                averageCadence: 170,
                averageStrideLength: 1.2,
                hrTimeInZones: nil
            )
        }
        return run
    }()
    
    let profile = UserProfile(unitPreference: .metric)

    // Create the viewmodel
    let viewModel = RunDetailViewModel(run: sampleRun, userProfile: profile, shoeStore: ShoeStore())
    
    RunDetailView(viewModel: viewModel, run: .constant(sampleRun))
        .environmentObject(ShoeStore())
}
