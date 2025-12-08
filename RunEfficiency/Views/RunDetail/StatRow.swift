//
//  StatRow.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/8/25.
//

import SwiftUI

struct StatRow: View {
    var statName: String
    var statValueString: String
    var body: some View {
        HStack{
            Text("\(statName):")
                .font(.headline)
                .padding(.horizontal)
            
            Spacer()
            
            Text(statValueString)
                .font(.headline)
                .bold()
        }
        
    }
}

#Preview {
    StatRow(statName: "Elevation Gain", statValueString: "145ft")
}
