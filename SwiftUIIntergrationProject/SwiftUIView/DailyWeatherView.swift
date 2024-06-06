
import SwiftUI

struct DailyWeatherView: View {
    @StateObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10.0) {
                ForEach(weatherViewModel.weather?.forecast.forecastItems ?? []) { weather in
                    DailyWeatherCell(weather: weather)
                }
            }
        }
    }
    private func DailyWeatherCell(weather: ForecastItemDisplayData) -> some View {
        VStack(spacing: 10) {
            Text(weather.timeDateText)
                .padding([.bottom], 16)
            Text(weather.temperatureText)
                .padding(8.0)
            Text( weather.weatherText)
                .padding(8.0)
            Text( weather.windSpeedText)
                .padding(8.0)
            Text(weather.windDirectionText)
                .padding(8.0)
            Text(weather.rainText ?? "No rain")
                .padding(8.0)

            
        }
        .font(.system(size: 16.0))
        .foregroundStyle(Color.black)
        .padding()
        .background(Rectangle().stroke())
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(weatherViewModel: WeatherViewModel())
    }
}
