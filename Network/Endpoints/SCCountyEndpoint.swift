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
      return "spots/\(county)"
    case let .tide(county):
      return "tide/\(county)"
    case let .waterTemperature(county):
      return "water-temperature/\(county)"
    case let .wind(county):
      return "wind/\(county)"
    }
  }
}
