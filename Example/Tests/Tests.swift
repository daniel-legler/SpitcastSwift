import XCTest
import SpitcastSwift

class Tests: XCTestCase {
    
    func testForecastEndpoint() {
        let expectation = XCTestExpectation(description: "API Call to Return Something")
        SpitcastAPI.spotForecast(id: SpotData.LosAngeles.ManhattanBeach.id) { (result) in
            result.withValue({ (reports) in
                print(reports.first!.shape)
            })
            result.withError({ (error) in
                print(error.localizedDescription)
            })
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAllSpotsEndpoint() {
        let expectation = XCTestExpectation(description: "API Call to Return Something")
        SpitcastAPI.allSpots() { (result) in
            result.withValue({ (reports) in
                print(reports.first!.name)
            })
            result.withError({ (error) in
                print(error.localizedDescription)
            })
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

}
