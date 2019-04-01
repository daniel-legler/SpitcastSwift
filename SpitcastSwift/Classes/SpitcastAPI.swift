import Foundation

public final class SpitcastAPI {

  /// A typealias for the handler to execute with the result of a network fetch.
  public typealias SCResult<T: SCModel> = (Result<[T], SCError>) -> Void

  /// A network manager instance to use for the network call.
  private static var network: SCNetworkManager {
    return SCNetworkManager()
  }
  
  // MARK: - Public

  /// Fetches all available surf spots from SpitCast. Note that not all spots have forecast, tide,
  /// wind, etc. data. For only surf spots with usable data use `forecastableSpots(_:)`.
  ///
  /// - Parameter completion: Handler to execute with the result of the network fetch.
  public static func allSpots(_ completion: @escaping SCResult<SCSurfSpot>) {
    network.fetch(endpoint: SCSpotEndpoint.all, completion)
  }
  
  /// Fetches all surf spots from SpitCast that have surf forecast data available.
  ///
  /// - Parameter completion: Handler to execute with the result of the network fetch.
  public static func forecastableSpots(_ completion: @escaping SCResult<SCSurfSpot>) {
    network.fetch(endpoint: SCSpotEndpoint.all) { (results: Result<[SCSurfSpot], SCError>) in
      do {
        let allSpots = try results.get()
        let filteredSpots = allSpots.filter { ForecastableSpotIds.contains($0.spotId) }
        completion(.success(filteredSpots))
      } catch {
        completion(.failure(SCError.requestFailed(error)))
      }
    }
  }

  /// Fetches the surf forecast of a given spot ID. Use the helper `Spots` struct to find the
  /// desired spot ID.
  ///
  /// - Parameters:
  ///   - id: The spot ID of which to fetch a surf forecast.
  ///   - completion: Handler to execute with the result of the network fetch.
  public static func spotForecast(
    id: Int,
    _ completion: @escaping SCResult<SCForecast>
  ) {
    network.fetch(endpoint: SCSpotEndpoint.forecast(spotId: id), completion)
  }

  /// Fetches a list of surf spots nearby a given latitude/longitude.
  ///
  /// - Parameters:
  ///   - lat: The latitude of the coordinate to search nearby for surf spots.
  ///   - lon: The longitude of the coordinate to search nearby for surf spots.
  ///   - completion: Handler to execute with the result of the network fetch.
  public static func spotsNear(
    lat: Float,
    lon: Float,
    _ completion: @escaping SCResult<SCNearbySpot>
  ) {
    network.fetch(endpoint: SCSpotEndpoint.nearby(lat: lat, lon: lon), completion)
  }

  /// Fetches a list of surf spots that are nearby another surf spot with a given spot ID.
  ///
  /// - Parameters:
  ///   - spotId: The spot ID of the spot for which to search nearby.
  ///   - completion: Handler to execute with the result of the network fetch.
  public static func neigboringSpots(
    spotId: Int,
    _ completion: @escaping SCResult<SCNearbySpot>
  ) {
    network.fetch(endpoint: SCSpotEndpoint.neighbors(spotId: spotId), completion)
  }

  /// Fetches a list of spots that are in the given county.
  ///
  /// - Parameters:
  ///   - county: The county of which to fetch the list of surf spots.
  ///   - completion: Handler to execute with the result of the network fetch.
  public static func spotsInCounty(
    _ county: String,
    _ completion: @escaping SCResult<SCSurfSpot>
  ) {
    network.fetch(endpoint: SCCountyEndpoint.spots(county: county), completion)
  }

  /// Fetches the tide report of the given county. Use the `County` struct for supported names.
  ///
  /// - Parameters:
  ///   - county: The county of which to fetch the tide report.
  ///   - completion: Handler to execute with the result of the network fetch.
  public static func tideReport(
    county: String,
    _ completion: @escaping SCResult<SCTide>
  ) {
    network.fetch(endpoint: SCCountyEndpoint.tide(county: county), completion)
  }

  /// Fetches the wind report of the given county. Use the `County` struct for supported names.
  ///
  /// - Parameters:
  ///   - county: The county of which to fetch the wind report.
  ///   - completion: Handler to execute with the result of the network fetch.
  public static func windReport(
    county: String,
    _ completion: @escaping SCResult<SCWind>
  ) {
    network.fetch(endpoint: SCCountyEndpoint.wind(county: county), completion)
  }

  /// Fetches the water temperature of the given county. Use the `County` struct for supported
  /// names.
  ///
  /// - Parameters:
  ///   - county: The county of which to fetch the water temperature.
  ///   - completion: Handler to execute with the result of the network fetch.
  public static func waterTemperature(
    county: String,
    _ completion: @escaping SCResult<SCTemperature>
  ) {
    network.fetch(endpoint: SCCountyEndpoint.waterTemperature(county: county), completion)
  }
}
