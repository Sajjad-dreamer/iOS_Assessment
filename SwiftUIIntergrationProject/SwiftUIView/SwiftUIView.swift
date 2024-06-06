//
//  SwiftUIMixView.swift
//  SwiftUIIntergrationProject
//
//  Created by Yuchen Nie on 4/8/24.
//

import Foundation
import SwiftUI

// TODO: Create SwiftUI View that either pre-selects address or user enters address, and retrieves current weather plus weather forecast

struct SwiftUIView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    @State var viewState: ViewSate = .default
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                SearchCityView(weatherViewModel: weatherViewModel)
                Spacer()
                switch weatherViewModel.viewState {
                case .default:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .success:
                    ScrollView(showsIndicators: false) {
                        FullWeatherView(weatherViewModel: weatherViewModel)
                           .padding()
                    }
                case .failure(let error):
                    VStack {
                        Text("Failed with error: \(error)")
                    }
                }
                Spacer()

            }
            .background(Color.white)
        }
    }
}
