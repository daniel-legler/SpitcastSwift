import Foundation

enum SCSpotEndpoint {
    case all
    case forecast(spotId: Int)
    case nearby(lat: Float, lon: Float)
    case neighbors(spotId: Int)
}

extension SCSpotEndpoint: Endpoint {
    var baseUrl: URL {
        return URL(string: "http://api.spitcast.com/api/spot/")!
    }

    var path: String {
        switch self {
        case .all:
            return "all"
        case .forecast(let spotId):
            return "forecast/\(spotId)"
        case .nearby:
            return "nearby"
        case .neighbors(let spotId):
            return "neighbors/\(spotId)"
        }
    }
}
