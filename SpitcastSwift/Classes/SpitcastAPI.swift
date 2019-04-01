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

public enum SCError: Error, LocalizedError {
  case badRequest
  case requestFailed(Error)
  case emptyResponse
  case serializationFailed
  
  public var errorDescription: String? {
    switch self {
    case .badRequest:
      return "The request couldn't be formed properly."
    case .requestFailed(let error):
      return "The request failed with error: \(error.localizedDescription)"
    case .emptyResponse:
      return "The API didn't return any data."
    case .serializationFailed:
      return "Data could not be serialized."
    }
  }
}

class SCNetworkManager {
  
  private let queue = DispatchQueue(label: UUID().uuidString, qos: .utility)
  
  // MARK: - URLSession Request
  
  func fetch<T: SCModel>(
    endpoint: Endpoint,
    _ completion: @escaping (Result<[T], SCError>) -> Void)
  {
    queue.async {
      guard let request = endpoint.request() else {
        completion(.failure(SCError.badRequest))
        return
      }
      print(request)
      let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
        guard error == nil else {
          completion(.failure(SCError.requestFailed(error!)))
          return
        }
        guard let data = data else {
          completion(.failure(SCError.emptyResponse))
          return
        }
        completion(self.serialize(data))
      }
      task.resume()
    }
  }
  
  private func serialize<T: SCModel>(_ data: Data) -> Result<[T], SCError> {
    do {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .formatted(T.dateFormatter)
      if let objects = try? decoder.decode([T].self, from: data) {
        return .success(objects)
      } else {
        let object = try decoder.decode(T.self, from: data)
        return .success([object])
      }
    } catch {
      return .failure(SCError.serializationFailed)
    }
  }
}
