
import SwiftUI

struct SearchCityView: View {
    @ObservedObject var weatherViewModel: WeatherViewModel
    @State private var startCity = Constants.city
    
    var body: some View {
        HStack {
            TextField("Search City", text: $startCity)
                .padding(.leading, 10)
                .font(.system(size: 16.0))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.default)

            Button {
                weatherViewModel.city = startCity
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title3)
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct SearchCityView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
