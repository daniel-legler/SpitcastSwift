import Foundation
import Alamofire

final public class SpitcastAPI {
    
    // MARK: - Public API Functions
    
    public typealias SCResponse<T> = (Result<[T]>) -> Void
    
    public static func allSpots(_ completion: @escaping SCResponse<SCSurfSpot>) {
        fetch(endpoint: SCSpotEndpoint.all,
              serializer: DataRequest.spitcastSerializer(),
              completion)
    }

    public static func countySpots(_ county: String, _ completion: @escaping SCResponse<SCSurfSpot>) {
        fetch(endpoint: SCCountyEndpoint.spots(county: county),
              serializer: DataRequest.spitcastSerializer(),
              completion)
    }

    public static func spotForecast(id: Int, _ completion: @escaping SCResponse<SCForecast>) {
        fetch(endpoint: SCSpotEndpoint.forecast(spotId: id),
              serializer: DataRequest.spitcastSerializer(),
              completion)
    }
    
    public static func countyTide(_ county: String, _ completion: @escaping SCResponse<SCTide>) {
        fetch(endpoint: SCCountyEndpoint.tide(county: county),
              serializer: DataRequest.spitcastSerializer(),
              completion)
    }
    
    public static func countyWind(_ county: String, _ completion: @escaping SCResponse<SCWind>) {
        fetch(endpoint: SCCountyEndpoint.wind(county: county),
              serializer: DataRequest.spitcastSerializer(),
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
