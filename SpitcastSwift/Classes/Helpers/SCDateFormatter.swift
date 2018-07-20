import Foundation

extension DateFormatter {
    static func gmt() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy-M-d H"
        df.timeZone = TimeZone(secondsFromGMT: 0)
        return df
    }
    
    static func recorded() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "'Y'yyyy 'M'M 'D'd 'H'H"
        return df
    }
}
