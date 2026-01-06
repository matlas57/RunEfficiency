//
//  RunDetailView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI
internal import CoreData

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
                ScoreBar(
                    scoreName: "Cardio",
                    score: viewModel.economyComponentScores[0].score,
                    showBaselineDisclaimer: false)
                Divider()
                    .padding(.horizontal)
                ScoreBar(
                    scoreName: "Mechanics",
                    score: viewModel.economyComponentScores[1].score,
                    showBaselineDisclaimer: !viewModel.economyComponentScores[1].usesBaseline)
                Divider()
                    .padding(.horizontal)
                ScoreBar(
                    scoreName: "Power",
                    score: viewModel.economyComponentScores[2].score,
                    showBaselineDisclaimer: false
                )
                Divider()
                    .padding(.horizontal)
                ScoreBar(
                    scoreName: "Terrain",
                    score:  viewModel.economyComponentScores[3].score,
                    showBaselineDisclaimer: false
                )
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
    let previewController: AppDataController = {
        // 1. Load runs from JSON
        let jsonRepo = JSONRunRepository(loader: GarminBatchImporter())
        let sampleRuns: [Run]
        do {
            sampleRuns = try jsonRepo.fetchAllRuns().sorted { $0.date > $1.date }
        } catch {
            sampleRuns = []
            print("Failed to load JSON preview runs:", error)
        }

        // 2. Initialize controller
        let controller = AppDataController(
            runRepository: CoreDataRunRepository(
                context: PersistenceController.preview.container.viewContext
            ),
            economyScoreStore: EconomyScoreStore()
        )

        // 3. Save runs and recompute
        controller.savePreviewRuns(sampleRuns)

        return controller
    }()
    
    let sampleRun: Run = {
        let run: Run
        do {
            run = try previewController.fetchRuns().first!
        } catch {
            run = Run(
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
            print("Failed to load sample run, using default", error)
        }
        return run
    }()
    
    let viewModel = RunDetailViewModel(run: sampleRun, userProfile: UserProfile(), appDataController: previewController, shoeStore: ShoeStore())
    
    RunDetailView(viewModel: viewModel, run: .constant(sampleRun))
        .environmentObject(ShoeStore())
}
