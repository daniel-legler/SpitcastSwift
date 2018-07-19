import Foundation
import Alamofire

extension DataRequest {
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
