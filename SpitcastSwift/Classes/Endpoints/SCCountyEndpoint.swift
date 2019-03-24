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
    case let .spots(county):
      return "spots/\(sanitize(county))"
    case let .tide(county):
      return "tide/\(sanitize(county))"
    case let .waterTemperature(county):
      return "water-temperature/\(sanitize(county))"
    case let .wind(county):
      return "wind/\(sanitize(county))"
    }
  }

  private func sanitize(_ county: String) -> String {
    return county.lowercased().replacingOccurrences(of: " ", with: "-")
  }
}
