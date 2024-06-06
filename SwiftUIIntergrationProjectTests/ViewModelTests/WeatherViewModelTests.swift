
@testable import SwiftUIIntergrationProject
import XCTest
import Combine

class WeatherViewModelTests: XCTestCase {

    func testLocationInit() {
        let viewModel = WeatherViewModel()
        viewModel.city = "Delhi"
        XCTAssertEqual(viewModel.viewState, ViewSate.loading)
    }
    
    func testWeatherSuccess() {
        let viewModel = WeatherViewModel()
        viewModel.city = "Hyderabad"
        
    }
}
