import Foundation

typealias SCModel = Codable & SCModelProtocol

protocol SCModelProtocol {
  static var dateFormatter: DateFormatter { get }
}
