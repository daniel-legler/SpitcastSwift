import Foundation

protocol Endpoint {
  func url() -> URL?
  func request() -> URLRequest?
  var baseUrl: URL { get }
  var path: String { get }
}

extension Endpoint {
  func url() -> URL? {
    let sanitizedPath = path.sanitized()
    return URL(string: sanitizedPath, relativeTo: baseUrl)
  }

  func request() -> URLRequest? {
    guard let requestUrl = url() else {
      return nil
    }
    var request = URLRequest(url: requestUrl)
    request.httpMethod = "GET"
    return request
  }
}

extension String {
  public func sanitized() -> String {
    return self.lowercased().replacingOccurrences(of: " ", with: "-")
  }
}
