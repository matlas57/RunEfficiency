//
//  RunRowView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct RunRowView: View {
    var run: Run
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(run.name)
                    .font(.headline)
                Text(run.dateString)
            }
            Spacer()
            HStack(spacing: 8) {
                Text(run.distanceString)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            
        }
        .padding()
        .background(.secondary.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    RunRowView(run: MockData.sampleRuns[0])
}
