import Foundation

struct MockData {
    static let sampleRuns: [Run] = [
        Run(
            date: Date().addingTimeInterval(-86400 * 5),
            name: "Easy Morning Run",
            distanceMeters: 6800,              // 6.8 km
            durationSeconds: 38 * 60,          // 38 minutes
            elevationGainMeters: 55,
            averageHeartRate: 140,
            maxHeartRate: 158,
            averageCadence: 166,
            averageStrideLength: 1.05
        ),
        Run(
            date: Date().addingTimeInterval(-86400 * 2),
            name: "Track Intervals",
            distanceMeters: 11900,             // 11.9 km
            durationSeconds: 62 * 60,          // 1 hr 2 min
            elevationGainMeters: 120,
            averageHeartRate: 162,
            maxHeartRate: 181,
            averageCadence: 176,
            averageStrideLength: 1.21
        ),
        Run(
            date: Date().addingTimeInterval(-86400 * 3),
            name: "Sunday Long Run",
            distanceMeters: 16500,             // 16.5 km
            durationSeconds: 92 * 60,          // 1 hr 32 min
            elevationGainMeters: 210,
            averageHeartRate: 148,
            maxHeartRate: 170,
            averageCadence: 170,
            averageStrideLength: 1.15
        )
    ]
    
    static let sampleUserProfile = UserProfile(unitPrefernce: .imperial)
}
