import SwiftUI

struct FullWeatherView: View {
    @StateObject var weatherViewModel: WeatherViewModel
    var body: some View {
        VStack {
            CurrentlyWeatherView(weatherViewModel: weatherViewModel)
                .padding()
            Text(Constants.forecastDays)
                .font(.system(size: 18.0, weight: .bold))
            DailyWeatherView(weatherViewModel: weatherViewModel)
        }
    }
}

struct FullWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        FullWeatherView(weatherViewModel: WeatherViewModel())
    }
}
