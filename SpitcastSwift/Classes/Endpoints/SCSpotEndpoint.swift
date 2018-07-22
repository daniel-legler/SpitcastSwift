import Foundation
import Alamofire

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

    func url() throws -> URL {
        let url = URL(string: path, relativeTo: baseUrl)!

        switch self {
        case .all, .forecast, .neighbors:
            return url
        case .nearby(let lat, let lon):
            var components = URLComponents(string: url.absoluteString)
            components?.queryItems = [ URLQueryItem(name: "latitude", value: String(lat)),
                                       URLQueryItem(name: "longitude", value: String(lon))]
            return (try components?.asURL()) ?? url
        }
    }
}
