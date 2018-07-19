import Foundation
enum SCCountyEndpoint {
    case spots(county: String)
    case tide(county: String)
    case waterTemperature(county: String)
    case wind(county: String)
}

extension SCCountyEndpoint: Endpoint {
    var baseUrl: URL {
        return URL(string: "http://api.spitcast.com/api/county/")!
    }

    var path: String {
        switch self {
        case .spots(let county):
            return "spots/\(county)"
        case .tide(let county):
            return "tide/\(county)"
        case .waterTemperature(let county):
            return "water-temperature/\(county)"
        case .wind(let county):
            return "wind/\(county)"
        }
    }
}
