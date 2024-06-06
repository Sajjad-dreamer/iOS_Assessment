
import SwiftUI

struct CurrentlyWeatherView: View {
    @StateObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        VStack(spacing: 0) {
                VStack(alignment: .center) {
                    Text(weatherViewModel.weather?.currentWeather.nameOfLocationText ?? Constants.city)
                        .font(.system(size: 18.0, weight: .bold))
                    Text(weatherViewModel.weather?.currentWeather.currentWeatherText ?? "")
                    Text (weatherViewModel.weather?.currentWeather.temperatureText ?? "")
                    Text(weatherViewModel.weather?.currentWeather.windSpeedText ?? "")
                    Text(weatherViewModel.weather?.currentWeather.windDirectionText ?? "")
            }
        }
        .padding()
    }
}

struct CurrentlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentlyWeatherView(weatherViewModel: WeatherViewModel())
    }
}
