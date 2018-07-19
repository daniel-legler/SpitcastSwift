import Foundation

class SCDateFormatter: DateFormatter {
    override init() {
        super.init()
        self.dateFormat = "yyyy-M-d H"
        self.timeZone = TimeZone(secondsFromGMT: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
