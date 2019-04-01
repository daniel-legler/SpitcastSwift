import Foundation

public final class SpitcastAPI {

  // MARK: - Public API

  public typealias SCResult<T: SCModel> = (Result<[T], SCError>) -> Void

  private static var network: SCNetworkManager {
    return SCNetworkManager()
  }
  
  public static func allSpots(_ completion: @escaping SCResult<SCSurfSpot>) {
    network.fetch(endpoint: SCSpotEndpoint.all, completion)
  }

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

  public static func spotForecast(id: Int,
                                  _ completion: @escaping SCResult<SCForecast>) {
    network.fetch(endpoint: SCSpotEndpoint.forecast(spotId: id), completion)
  }

  public static func spotsNear(
    lat: Float,
    lon: Float,
    _ completion: @escaping SCResult<SCNearbySpot>
  ) {
    network.fetch(endpoint: SCSpotEndpoint.nearby(lat: lat, lon: lon), completion)
  }

  public static func neigboringSpots(spotId: Int,
                                     _ completion: @escaping SCResult<SCNearbySpot>) {
    network.fetch(endpoint: SCSpotEndpoint.neighbors(spotId: spotId), completion)
  }

  public static func spotsInCounty(_ county: String,
                                   _ completion: @escaping SCResult<SCSurfSpot>) {
    network.fetch(endpoint: SCCountyEndpoint.spots(county: county), completion)
  }

  public static func tideReport(county: String,
                                _ completion: @escaping SCResult<SCTide>) {
    network.fetch(endpoint: SCCountyEndpoint.tide(county: county), completion)
  }

  public static func windReport(county: String,
                                _ completion: @escaping SCResult<SCWind>) {
    network.fetch(endpoint: SCCountyEndpoint.wind(county: county), completion)
  }

  public static func waterTemperature(county: String,
                                      _ completion: @escaping SCResult<SCTemperature>) {
    network.fetch(endpoint: SCCountyEndpoint.waterTemperature(county: county), completion)
  }
}
