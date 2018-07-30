import Foundation
import Alamofire

extension DataRequest {
    static func spitcast<T: SCModel>() -> DataResponseSerializer<[T]> {
        return DataResponseSerializer { (_, _, data, error) -> Result<[T]> in
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
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
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
            }
        }
    }
    
    static func forecastableSpots() -> DataResponseSerializer<[SCSurfSpot]> {
        return DataResponseSerializer { (_, _, data, error) -> Result<[SCSurfSpot]> in
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(SCSurfSpot.dateFormatter)
                let allSpots = try decoder.decode([SCSurfSpot].self, from: data)
                let existingSpots = allSpots.filter({ (spot) -> Bool in
                    return ![Counties.DelNorte,
                             Counties.Humboldt,
                             Counties.Sonoma,
                             Counties.Mendocino].contains(spot.county)
                })
                return .success(existingSpots)
            } catch {
                return .failure(AFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
            }
        }

    }
}
