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
    // Published properties for UI binding
    @Published var cityName: String = ""
    @Published var currentDateTime: String = ""
    @Published var temperature: Double = 0.0
    @Published var feelsLike: Double = 0.0
    @Published var tempMin: Double = 0.0
    @Published var tempMax: Double = 0.0
    @Published var weatherDescription: String = ""
    @Published var forecast: [DailyForecast] = []
    @Published var weatherID: Int?
    @Published var weatherMain: String?

    private var cancellables = Set<AnyCancellable>()
    private let locationManager = LocationManager()

    init() {
        // Observe changes in location
        // Observe location updates
        locationManager.$coordinate
            .compactMap { $0 } // Proceed only when not nil
            .sink { [weak self] coordinate in
                self?.fetchData(lat: coordinate.latitude, lon: coordinate.longitude)
            }
            .store(in: &cancellables)

        // Update current date/time every minute
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.updateDateTime()
        }
        updateDateTime() // Initial call
    }

    private func updateDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        currentDateTime = formatter.string(from: Date())
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
            self.weatherDescription = response.weather.first?.description.capitalized ?? ""
            self.weatherID = response.weather.first?.id
            self.weatherMain = response.weather.first?.main ?? ""
        }
    }

    private func fetchForecast(lat: Double, lon: Double) {
        NetworkManager.shared.fetchForecast(lat: lat, lon: lon) { [weak self] forecastResponse in
            guard let self = self, let response = forecastResponse else { return }
            self.forecast = Array(response.daily.prefix(7)) // Show next 7 days
        }
    }
}
