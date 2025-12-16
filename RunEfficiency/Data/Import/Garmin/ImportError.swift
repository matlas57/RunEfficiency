//
//  ImportError.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/16/25.
//

import Foundation

enum ImportError: Error {
    case notARun
    case invalidDate
    case decodingFailed
}
