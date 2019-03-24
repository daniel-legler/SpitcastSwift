import Foundation

public struct SCTide: SCModel {
  public var date: Date
  public var name: String
  public var tideFeet: Double
  public var tideMeters: Double

  private enum CodingKeys: String, CodingKey {
    case date = "gmt"
    case name
    case tideFeet = "tide"
    case tideMeters = "tide_meters"
  }

  static var dateFormatter: DateFormatter = .gmt()
}
