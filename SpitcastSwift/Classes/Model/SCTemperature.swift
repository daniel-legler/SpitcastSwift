import Foundation

public struct SCTemperature: SCModel {
    public var county: String
    public var celcius: Double
    public var fahrenheit: Double
    public var recorded: Date
    
    private enum CodingKeys: String, CodingKey {
        case county
        case celcius
        case fahrenheit
        case recorded
    }
    
    static var dateFormatter: DateFormatter = .recorded()

}
