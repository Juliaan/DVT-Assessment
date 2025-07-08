//
//  WeatherViewModel.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import Foundation
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    // use @Published properties for UI binding
    @Published var isLoading = true
    @Published var cityName: String = ""
    @Published var temperature: Double = 0.0
    @Published var feelsLike: Double = 0.0
    @Published var tempMin: Double = 0.0
    @Published var tempMax: Double = 0.0
    @Published var forecast: [DailyForecast] = []
    @Published var weatherID: Int?
    @Published var weatherMain: String?

    private var cancellables = Set<AnyCancellable>()
    private let locationManager = LocationManager()

    init() {
        
        /*  - Observe/listen for changes in location
            - Observe location updates
            - ensure both lat and lon exists before we call and continue tto call api
            - subscribe to changes in coordinates
        */
        locationManager.$coordinates
            .compactMap { $0 } // execute only when exist
            .sink { [weak self] coordinate in
                
                self?.locationManager.stopLocationUpdates()
                self?.fetchData(lat: coordinate.latitude, lon: coordinate.longitude)
            }
            .store(in: &cancellables)
        
    }
    
    private func fetchData(lat: Double, lon: Double) {
        fetchWeather(lat: lat, lon: lon)
        fetchForecast(lat: lat, lon: lon)
    }

    private func fetchWeather(lat: Double, lon: Double) {
        NetworkManager.shared.fetchWeather(lat: lat, lon: lon) { [weak self] weatherResponse in
            guard let self = self, let response = weatherResponse else { return }
            self.cityName = response.name
            self.temperature = response.main.temp
            self.feelsLike = response.main.feels_like
            self.tempMin = response.main.temp_min
            self.tempMax = response.main.temp_max
            self.weatherID = response.weather.first?.id
            self.weatherMain = response.weather.first?.main ?? ""
        }
    }

    private func fetchForecast(lat: Double, lon: Double) {
        NetworkManager.shared.fetchForecast(lat: lat, lon: lon) { [weak self] forecastResponse in
            guard let self = self, let response = forecastResponse else { return }
            self.forecast = Array(response.daily.prefix(7)) // Show next 7 days
            self.isLoading = false
        }
    }
}
