//
//  RunFormatter.swift
//  RunEfficiency
//
//  Created by Matan Atlas on 12/6/25.
//

import Foundation

// Singleton service class for creating formatted strings from fields from runs
final class RunFormatter {
    static let shared = RunFormatter()
    private init() {}
    
    // Pace 
    func paceString(for run: Run, units: UnitPreference) -> String {
        let seconds: Double
        switch units {
        case .metric:
            seconds = run.paceSecondsPerKm
        case .imperial:
            seconds = run.paceSecondsPerMile
        }
        return formatPace(seconds, units: units)
    }
    
    private func formatPace(_ seconds: Double, units: UnitPreference) -> String {
        guard seconds > 0 else { return "--" }
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        switch units {
            case .metric:
                return String(format: "%d:%02d min/km", minutes, secs)
            case .imperial:
                return String(format: "%d:%02d min/mi", minutes, secs)
        }
    }
        
    // Distance
    func distanceString(for run: Run, units: UnitPreference) -> String {
        let distance: Double
        let unitLabel: String
        switch units {
        case .metric:
            distance = run.distanceMeters / 1000.0
            unitLabel = "km"
        case .imperial:
            distance = run.distanceMeters / 1609.34
            unitLabel = "mi"
        }
        return String(format: "%.2f %@", distance, unitLabel)
    }
    
    // Duration
    func durationString(for run: Run) -> String {
        let totalSeconds = run.durationSeconds
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
    
    // Heart Rate
    func heartRateString(_ hr: Double?) -> String {
        guard let hr else { return "--" }
        return "\(Int(hr)) bpm"
    }
    
    func maxHeartRateString(_ hr: Int?) -> String {
        guard let hr else { return "--" }
        return "\(hr) bpm"
    }
    
    // Elevation Gain
    func elevationString(_ meters: Double?, units: UnitPreference) -> String {
        guard let meters else { return "--" }
        switch units {
        case .metric:
            return String(format: "%.0f m", meters)
        case .imperial:
            return String(format: "%.0f ft", meters * 3.28084)
        }
    }
    
    // Cadence
    func cadenceString(_ cadence: Double?) -> String {
        guard let cadence else { return "--" }
        return "\(Int(cadence)) spm"
    }
    
    // Stride length
    func strideLengthString(_ stride: Double?, units: UnitPreference) -> String {
        guard let stride else { return "--" }
        switch units {
        case .metric:
            return String(format: "%.2f m", stride)
        case .imperial:
            return String(format: "%.2f ft", stride * 3.28084)
        }
    }
    
    // Date String
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium  // e.g., Feb 6, 2025
        formatter.timeStyle = .none
        return formatter
    }

    func dateString(for date: Date) -> String {
        dateFormatter.string(from: date)
    }

    func dateString(for run: Run) -> String {
        dateString(for: run.date)
    }
}
