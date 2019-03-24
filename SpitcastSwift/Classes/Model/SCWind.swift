import Foundation

public struct SCWind: SCModel {
  public var date: Date
  public var county: String
  public var speedKts: Double
  public var speedMph: Double
  public var directionDegrees: Double
  public var cardinalDirection: String

  private enum CodingKeys: String, CodingKey {
    case date = "gmt"
    case county = "name"
    case speedKts = "speed_kts"
    case speedMph = "speed_mph"
    case directionDegrees = "direction_degrees"
    case cardinalDirection = "direction_text"
  }

  static var dateFormatter: DateFormatter = .gmt()
}
