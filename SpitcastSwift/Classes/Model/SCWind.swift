import Foundation

public struct SCWind: Codable {
    public var date: Date
    public var county: String
    public var speedKts: Double
    public var speedMph: Double
    public var directionDegrees: Double
    public var cardinalDir: String
    
    private enum CodingKeys: String, CodingKey {
        case date = "gmt"
        case county = "name"
        case speedKts = "speed_kts"
        case speedMph = "speed_mph"
        case directionDegrees = "direction_degrees"
        case cardinalDir = "direction_text"
    }
}
