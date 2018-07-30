import Foundation
import Alamofire

final public class SpitcastAPI {
    
    // MARK: - Public API
    
    public typealias SCResult<T> = (Result<[T]>) -> Void
    
    // The Spitcast API provides ONLY wind/tide (not swell) information for these counties:
    //  - Mendocino, Humboldt, Del Norte, Sonoma
    public static func allSpots(includeUnsupportedCounties: Bool = false,
                                _ completion: @escaping SCResult<SCSurfSpot>) {
        fetch(endpoint: SCSpotEndpoint.all,
              serializer: includeUnsupportedCounties ? DataRequest.spitcast() : DataRequest.forecastableSpots(),
              completion)
    }

    public static func spotForecast(id: Int,
                                    _ completion: @escaping SCResult<SCForecast>) {
        fetch(endpoint: SCSpotEndpoint.forecast(spotId: id),
              serializer: DataRequest.spitcast(),
              completion)
    }
    
    public static func spotsNear(lat: Float, lon: Float,
                                 _ completion: @escaping SCResult<SCNearbySpot>) {
        fetch(endpoint: SCSpotEndpoint.nearby(lat: lat, lon: lon),
              serializer: DataRequest.spitcast(),
              completion)
    }
    
    public static func neigboringSpots(spotId: Int,
                                       _ completion: @escaping SCResult<SCSurfSpot>) {
        fetch(endpoint: SCSpotEndpoint.neighbors(spotId: spotId),
              serializer: DataRequest.spitcast(),
              completion)
    }
    
    public static func spotsInCounty(_ county: String,
                                     _ completion: @escaping SCResult<SCSurfSpot>) {
        fetch(endpoint: SCCountyEndpoint.spots(county: county),
              serializer: DataRequest.spitcast(),
              completion)
    }

    public static func tideReport(county: String,
                                  _ completion: @escaping SCResult<SCTide>) {
        fetch(endpoint: SCCountyEndpoint.tide(county: county),
              serializer: DataRequest.spitcast(),
              completion)
    }
    
    public static func windReport(county: String,
                                  _ completion: @escaping SCResult<SCWind>) {
        fetch(endpoint: SCCountyEndpoint.wind(county: county),
              serializer: DataRequest.spitcast(),
              completion)
    }
    
    public static func waterTemperature(county: String,
                                        _ completion: @escaping SCResult<SCTemperature>) {
        fetch(endpoint: SCCountyEndpoint.waterTemperature(county: county),
              serializer: DataRequest.spitcast(),
              completion)
    }
    
    // MARK: - Internal Request Formation
    
    private static func fetch<T: DataResponseSerializerProtocol>(endpoint: Endpoint,
                              serializer: T,
                              _ completion: @escaping (Result<T.SerializedObject>) -> ()) {
        do {
            let request = try endpoint.request()
            Alamofire.request(request)
                .validate()
                .response(responseSerializer: serializer) { (dataResponse) in
                    completion(dataResponse.result)
            }
        } catch {
            completion(.failure(error))
        }
    }
}
