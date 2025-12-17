//
//  ScoreBar.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/17/25.
//

import SwiftUI

struct ScoreBar: View {
    var scoreName: String
    var score: Double
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Text(scoreName + " Score:")
                    .bold()
                
                ZStack(alignment: .leading) {
                    // Background track
                    RoundedRectangle(cornerRadius: 8)
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [.red, .yellow, .green]),
                            startPoint: .leading,
                            endPoint: .trailing))
                        .frame(height: 16)
                    
                    // Score Indicator
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 8, height: 30)
                            .foregroundColor(.gray)
                            .opacity(0.9)
                        Text(String(Int(score)))
                            .bold()
                    }
                    .offset(x: CGFloat(score / 100) * (geometry.size.width - 20), y: 12)
                }
            }
        }
        .frame(height: 16)
        .padding(.horizontal)
        .padding(.bottom, 65)
    }
}

#Preview {
    VStack {
        ScoreBar(scoreName: "Cardio", score: 100.0)
            .padding(.bottom, 75)
        ScoreBar(scoreName: "Cardio", score: 50.0)
            .padding(.bottom, 75)
        ScoreBar(scoreName: "Cardio", score: 0.0)
    }
}
