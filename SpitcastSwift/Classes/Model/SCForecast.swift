import Foundation

public struct SCForecast: Codable {
    
    public struct SCShapeDetail: Codable {
        public var swell: String
        public var tide: String
        public var wind: String
    }
    
    public var latitude: Double
    public var longitude: Double
    public var date: Date
    public var shape: String
    public var shapeDetails: SCShapeDetail
    public var size: Double
    public var spotId: Int
    public var name: String
    
    private enum CodingKeys: String, CodingKey {
        case date = "gmt"
        case shape = "shape_full"
        case shapeDetails = "shape_detail"
        case size = "size_ft"
        case spotId = "spot_id"
        case name = "spot_name"
        case latitude
        case longitude
    }
}
