import Foundation

protocol Endpoint {
  func url() throws -> URL
  func request() throws -> URLRequest
  var baseUrl: URL { get }
  var path: String { get }
}

extension Endpoint {
  func url() throws -> URL {
    return URL(string: path, relativeTo: baseUrl)!
  }

  func request() throws -> URLRequest {
    let requestUrl = try url()
    print(requestUrl)
    return try URLRequest(url: requestUrl, method: .get)
  }
}
