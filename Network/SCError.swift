import Foundation

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
