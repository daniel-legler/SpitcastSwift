import Foundation
import Alamofire

final public class SpitcastAPI {
    
    // MARK: - Spot Endpoint
    
    public static func allSpots(_ completion: @escaping (Result<[SCSurfSpot]>) -> Void) {
        fetch(endpoint: SCSpotEndpoint.all,
              serializer: DataRequest.allSpotsSerializer(),
              completion)
    }

    public static func forecast(spotId: Int, _ completion: @escaping (Result<[SCForecast]>) -> Void) {
        fetch(endpoint: SCSpotEndpoint.forecast(spotId: spotId),
              serializer: DataRequest.spitcastSerializer(),
              completion)
    }
    
    // MARK: - County Endpoint
    
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


