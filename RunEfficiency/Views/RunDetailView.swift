//
//  RunDetailView.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/4/25.
//

import SwiftUI

struct RunDetailView: View {
    var run: Run
    var body: some View {
        Text(run.name)
    }
}

#Preview {
    RunDetailView(run: MockData.sampleRuns[0])
}
