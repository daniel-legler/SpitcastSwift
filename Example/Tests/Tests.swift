import XCTest
import SpitcastSwift
import Alamofire

class Tests: XCTestCase {
    
    var expectation: XCTestExpectation!
    
    override func setUp() {
        expectation = XCTestExpectation()
    }
    
    func evaluate<T>(_ result: (Result<[T]>)) {
        result.withValue { (value) in
            print("API Returned: \(value)")
            self.expectation.fulfill()
        }
        result.withError { (error) in
            print(error.localizedDescription)
        }
    }
    
    func testAllSpots() {
        SpitcastAPI.allSpots(evaluate)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testForecastableSpots() {
        SpitcastAPI.forecastableSpots(evaluate)
        wait(for: [expectation], timeout: 5.0)
    }

    func testSpotForecast() {
        SpitcastAPI.spotForecast(id: Spots.LosAngeles.ManhattanBeach.id, evaluate)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSpotsNearby() {
        SpitcastAPI.spotsNear(lat: 34.0093515, lon: -118.49746820000001, evaluate)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testNeighboringSpots() {
        SpitcastAPI.neigboringSpots(spotId: Spots.Marin.ThePatch.id, evaluate)
    }
    
    func testSpotsInCounty() {
        SpitcastAPI.spotsInCounty(Counties.DelNorte, evaluate)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testTideReport() {
        SpitcastAPI.tideReport(county: Counties.Sonoma, evaluate)
        wait(for: [expectation], timeout: 5.0)
    }

    func testWindReport() {
        SpitcastAPI.windReport(county: Counties.Humboldt, evaluate)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testWaterTemperature() {
        SpitcastAPI.waterTemperature(county: Counties.Ventura, evaluate)
        wait(for: [expectation], timeout: 5.0)
    }
}
