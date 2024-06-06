@testable import SwiftUIIntergrationProject
import CoreLocation
import XCTest
import Combine

class WeatherServiceTests: XCTestCase {
    var urlSession: URLSession!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        urlSession = URLSession(configuration: configuration)
    }
    func testFetchWeatherValid() throws {
       
        let location = CLLocation(latitude: 21.9, longitude: 14.5)
        let expectation = XCTestExpectation(description: "response")
        
        WeatherService.retrieveCurrentWeather(location: location)
            .sink(receiveCompletion: { _ in }, receiveValue: { weather in
                XCTAssertEqual(weather.weather.count, 1)

                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 10)
    }

    func testFetchWeatherInValid() throws {
       
        let location = CLLocation(latitude: 2133.9, longitude: 14.5)
        let expectation = XCTestExpectation(description: "response")
        
        WeatherService.retrieveCurrentWeather(location: location)
            .sink{ operationResult in
                switch operationResult {
                    case .failure(let error):
                    XCTAssertEqual(error, SimpleError.dataParse("The data couldn’t be read because it is missing."))
                        expectation.fulfill()
                        break
                    case .finished:
                        break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10)
    }
    
    func testFetcForecastValid() throws {
       
        let location = CLLocation(latitude: 17.366, longitude: 78.476)
        let expectation = XCTestExpectation(description: "response")
        
        WeatherService.retrieveWeatherForecast(location: location)
            .sink(receiveCompletion: { _ in }, receiveValue: { forecast in
                XCTAssertEqual(forecast.city.name, "Hyderabad")

                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 10)
    }

    func testFetchForecaseInValid() throws {
       
        let location = CLLocation(latitude: 2133.9, longitude: 14.5)
        let expectation = XCTestExpectation(description: "response")
        
        WeatherService.retrieveWeatherForecast(location: location)
            .sink{ operationResult in
                switch operationResult {
                    case .failure(let error):
                    XCTAssertEqual(error, SimpleError.dataParse("The data couldn’t be read because it isn’t in the correct format."))
                        expectation.fulfill()
                        break
                    case .finished:
                        break
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10)
    }
}
