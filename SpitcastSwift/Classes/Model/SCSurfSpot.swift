import Foundation
public struct SCSurfSpot: Codable {
    public var spotId: Int
    public var name: String
    public var county: String
    public var latitude: Double
    public var longitude: Double
    
    private enum CodingKeys: String, CodingKey {
        case county = "county_name"
        case latitude
        case longitude
        case spotId = "spot_id"
        case name = "spot_name"
    }
}
