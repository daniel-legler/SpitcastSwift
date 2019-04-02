import Foundation

class SCNetworkManager {
  
  /// Performs a newtwork fetch request on the given endpoint.
  ///
  /// - Parameters:
  ///   - endpoint: The endpoint that will be used to form the request.
  ///   - completion: The completion handler that gets called when the network call succeeds/fails.
  func fetch<T: SCModel>(
    endpoint: Endpoint,
    _ completion: @escaping (Result<[T], SCError>) -> Void)
  {
    guard let request = endpoint.request() else {
      completion(.failure(SCError.badRequest))
      return
    }
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
  
  /// Serializes the provided data into the given SCModel.
  ///
  /// - Parameter data: The data to be serialized.
  /// - Returns: The result of attempting to serialize the data.
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
