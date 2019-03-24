import Foundation

public struct SCNearbySpot: SCModel {
  internal var coordinates: [Double]
  public var spotId: Int
  public var name: String

  private enum CodingKeys: String, CodingKey {
    case coordinates
    case spotId = "spot_id"
    case name = "spot_name"
  }

  public var longitude: Double {
    return coordinates[0]
  }

  public var latitude: Double {
    return coordinates[1]
  }

  static var dateFormatter: DateFormatter = .gmt()
}
