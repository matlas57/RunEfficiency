//
//  EnvironmentKeys.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 1/6/26.
//

import Foundation
import SwiftUI

private struct AppDataControllerKey: EnvironmentKey {
    static let defaultValue: AppDataController = {
        fatalError("AppDataController must be injected in the environment")
    }()
}

extension EnvironmentValues {
    var appDataController: AppDataController {
        get { self[AppDataControllerKey.self] }
        set { self[AppDataControllerKey.self] = newValue }
    }
}

