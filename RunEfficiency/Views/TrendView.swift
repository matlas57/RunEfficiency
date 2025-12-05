//
//  TrendView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI
import Charts

struct TrendView: View {
    var points: [RunningEconomyPoint]
    
    var body: some View {
        VStack {
            Text("Running Economy Trend")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            Chart {
                ForEach(points) { point in
                    LineMark(
                        x: .value("Date", point.date),
                        y: .value("Economy Score", point.efficiencyScore)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round))
                    PointMark(
                        x: .value("Date", point.date),
                        y: .value("Economy Score", point.efficiencyScore)
                    )
                    .symbolSize(25)
                }
            }
            .frame(height: 250)
            
            Text("Summary of trend data here")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    TrendView(points: DashboardViewModel().points)
}
