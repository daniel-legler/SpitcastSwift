import Foundation

protocol Endpoint {
  func url() -> URL?
  func request() -> URLRequest?
  var baseUrl: URL { get }
  var path: String { get }
}

extension Endpoint {
  func url() -> URL? {
    return URL(string: path, relativeTo: baseUrl)
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
