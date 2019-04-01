import Foundation

public struct SCSurfSpot: SCModel {

  static var dateFormatter: DateFormatter = .gmt()

  public var spotId: Int
  public var name: String
  public var county: String
  public var latitude: Double
  public var longitude: Double

  private enum AllSpotsCodingKeys: String, CodingKey {
    case county = "county_name"
    case latitude
    case longitude
    case spotId = "spot_id"
    case name = "spot_name"
  }
  
  private enum CountySpotsCodingKeys: String, CodingKey {
    case county = "county"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: AllSpotsCodingKeys.self)
    spotId = try container.decode(Int.self, forKey: .spotId)
    name = try container.decode(String.self, forKey: .name)
    longitude = try container.decode(Double.self, forKey: .longitude)
    latitude = try container.decode(Double.self, forKey: .latitude)
    guard container.contains(.county) else {
      let countySpotContainer = try decoder.container(keyedBy: CountySpotsCodingKeys.self)
      county = try countySpotContainer.decode(String.self, forKey: .county)
      return
    }
    county = try container.decode(String.self, forKey: AllSpotsCodingKeys.county)
  }
}
