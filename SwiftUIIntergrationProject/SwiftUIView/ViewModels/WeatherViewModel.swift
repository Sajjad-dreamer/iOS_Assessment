import SwiftUI
import CoreLocation
import Combine

enum ViewSate: Equatable {
    case `default`
    case loading
    case success
    case failure(SimpleError)
}

final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherDisplayData?
    @Published private(set) var viewState: ViewSate = .default
    @Published var city = Constants.city {
        didSet {
            getLocation()
        }
    }

    init() {
        getLocation()
    }

    private func getLocation() {
        viewState = .loading
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks,
               let place = places.first {
                self.getWeather(location: place.location!)
            } else {
                self.viewState = .failure(SimpleError.address)
                
            }
        }
    }

    private func getWeather(location: CLLocation) {
        let currentWeatherRequest = WeatherService.retrieveCurrentWeather(location: location)
        let forecastRequest = WeatherService.retrieveWeatherForecast(location: location)
        let token = Publishers.Zip(currentWeatherRequest, forecastRequest)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.viewState = .failure(error)
                    }
                    print("Failed with error: \(error)")
                    return
                case .finished:
                    print("Succeesfully finished!")
                }
            }, receiveValue: { value in
                DispatchQueue.main.async {
                    self.weather = WeatherDisplayData(currentWeather: CurrentWeatherDisplayData.init(from: value.0), forecast: ForecastDisplayData.init(from: value.1))
                    self.viewState = .success
                }

            }
            )
            
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 10))

        withExtendedLifetime(token, {})
    }
}
