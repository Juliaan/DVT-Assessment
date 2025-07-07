//
//  NetworkManager.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let apiKey = "87b595713dc97722bcfb83116209ed9a"

    func fetchWeather(lat: Double, lon: Double, completion: @escaping (WeatherResponse?) -> Void) {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: stringUrl) else { completion(nil); return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let decoded = try? JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async { completion(decoded) }
            } else {
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }

    func fetchForecast(lat: Double, lon: Double, completion: @escaping (OneCallResponse?) -> Void) {
        let stringUrl = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly&units=metric&appid=\(apiKey)"
        guard let url = URL(string: stringUrl) else { completion(nil); return }

        // https://api.openweathermap.org/data/3.0/onecall?lat=-34.035137772206035&lon=24.915311135378655&exclude=minutely,hourly&units=metric&appid=87b595713dc97722bcfb83116209ed9a
        
        //https://api.openweathermap.org/data/3.0/onecall?lat=-34.03523118838463&lon=24.91523394999758&exclude=current,minutely,hourly,alerts&units=metric&appid=87b595713dc97722bcfb83116209ed9a
        
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let decoded = try? JSONDecoder().decode(OneCallResponse.self, from: data)
                DispatchQueue.main.async { completion(decoded) }
            } else {
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
        
    }
    
}
