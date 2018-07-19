import Foundation
import Alamofire

extension DataRequest {
    static func allSpotsSerializer() -> DataResponseSerializer<[SCSurfSpot]> {
        return DataResponseSerializer { (_, _, data, error) -> Result<[SCSurfSpot]> in
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            do {
                let spots = try JSONDecoder().decode([SCSurfSpot].self, from: data)
                return .success(spots)
            } catch {
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
            }
        }
    }
    
    static func forecastSerializer() -> DataResponseSerializer<[SCForecast]> {
        return DataResponseSerializer { (_, _, data, error) -> Result<[SCForecast]> in
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(SCDateFormatter())
                let forecasts = try decoder.decode([SCForecast].self, from: data)
                return .success(forecasts)
            } catch {
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
            }
        }
    }
    
    static func spitcastSerializer<T: Codable>() -> DataResponseSerializer<[T]> {
        return DataResponseSerializer { (_, _, data, error) -> Result<[T]> in
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(SCDateFormatter())
                let objects = try decoder.decode([T].self, from: data)
                return .success(objects)
            } catch {
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
            }
        }
    }
}
