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
            return "spots/\(sanitize(county))"
        case .tide(let county):
            return "tide/\(sanitize(county))"
        case .waterTemperature(let county):
            return "water-temperature/\(sanitize(county))"
        case .wind(let county):
            return "wind/\(sanitize(county))"
        }
    }
    
    private func sanitize(_ county: String) -> String {
        return county.lowercased().replacingOccurrences(of: " ", with: "-")
    }
}
