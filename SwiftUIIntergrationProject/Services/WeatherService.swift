import Foundation
import Combine
import MapKit


  //
  ///
  /**
   TODO: Fill in this to retrieve current weather, and 5 day forecast 
   * Use func currentWeatherURL(location: CLLocation) -> URL? to get the CurrentWeatherJSONData
   * Use func forecastURL(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? to get the ForecastJSONData
  
   Once you have both the JSON Data, you can map:
    * CurrentWeatherJSONData -> CurrentWeatherDisplayData
    * ForecastJSONData ->ForecastDisplayData
   Both of these DisplayData structs contains the text you can bind/map to labels and we have included convience init that takes the JSON data so you can easily map them
   */
struct WeatherService {
  /// Example function signatures. Takes in location and returns publishers that contain
//  var retrieveWeatherForecast: (CLLocation) -> DataPublisher<ForecastJSONData?>
//  var retrieveCurrentWeather: (CLLocation) -> DataPublisher<CurrentWeatherJSONData?>
    static func retrieveWeatherForecast(location: CLLocation) -> AnyPublisher<ForecastJSONData, SimpleError> {
        let forecastURL = forecastURL(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let session = URLSession.shared
        let decoder = JSONDecoder()
        return session.dataTaskPublisher(for: forecastURL!)
            .map(\.data)
            .mapError { error in
                SimpleError.dataLoad(error.localizedDescription)
            }
            .decode(type: ForecastJSONData.self, decoder: decoder)
            .mapError { error in
                SimpleError.dataParse(error.localizedDescription)
            }
            .eraseToAnyPublisher()

    }
    
    static func retrieveCurrentWeather(location: CLLocation) -> AnyPublisher<CurrentWeatherJSONData, SimpleError> {
        let currentWeatherURL = currentWeatherURL(location: location)
        let session = URLSession.shared
        let decoder = JSONDecoder()
        return session.dataTaskPublisher(for: currentWeatherURL!)
            .map(\.data)
            .mapError { error in
                SimpleError.dataLoad(error.localizedDescription)
            }
            .decode(type: CurrentWeatherJSONData.self, decoder: decoder)
            .mapError { error in
                SimpleError.dataParse(error.localizedDescription)
            }

            .eraseToAnyPublisher()

    }

}

extension WeatherService {
  static var live = WeatherService()
}
