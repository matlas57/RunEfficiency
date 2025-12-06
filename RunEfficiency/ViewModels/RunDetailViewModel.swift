//
//  RunDetailViewModel.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/6/25.
//

import Foundation
import Combine

class RunDetailViewModel: ObservableObject {
    @Published var run: Run
    
    init(run: Run) {
        self.run = run
    }
    
    
}
