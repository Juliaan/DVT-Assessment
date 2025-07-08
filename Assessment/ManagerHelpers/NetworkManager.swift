//
//  NetworkManager.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private var apiKey = ""

    func getAPIKey() -> String {
        if let key = Bundle.main.object(forInfoDictionaryKey: "OpenWeatherAPIKey") as? String {
            return key
        }
        return "" // or handle error appropriately
    }
    
    func fetchWeather(lat: Double, lon: Double, completion: @escaping (WeatherResponse?) -> Void) {
        
        apiKey = getAPIKey()
        
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: stringUrl) else { completion(nil); return }

        URLSession.shared.dataTask(with: url) { data, response, error in
                
            // Check for error first
            if let error = error {
                print("Error fetching weather: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(nil) }
                return
            }
                
            // Check response to ensure we have a 200
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    // Successful response, decode data
                    if let data = data {
                        let decoded = try? JSONDecoder().decode(WeatherResponse.self, from: data)
                        DispatchQueue.main.async { completion(decoded) }
                    } else {
                        DispatchQueue.main.async { completion(nil) }
                    }
                    
                } else {
                    
                    print("HTTP Error: Status code \(httpResponse.statusCode)")
                    DispatchQueue.main.async { completion(nil) }
                    
                }
                
            } else {
                
                print("Invalid response")
                DispatchQueue.main.async { completion(nil) }
                
            }
        }.resume()
        
    }

    func fetchForecast(lat: Double, lon: Double, completion: @escaping (OneCallResponse?) -> Void) {
        
        apiKey = getAPIKey()
        
        let stringUrl = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly&units=metric&appid=\(apiKey)"
        guard let url = URL(string: stringUrl) else { completion(nil); return }

        URLSession.shared.dataTask(with: url) { data, response, error in
                
            // Check for errors first
            if let error = error {
                print("Error fetching forecast: \(error.localizedDescription)")
                DispatchQueue.main.async { completion(nil) }
                return
            }
                
            // Check response to ensure we have a 200
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    if let data = data {
                        let decoded = try? JSONDecoder().decode(OneCallResponse.self, from: data)
                        DispatchQueue.main.async { completion(decoded) }
                    } else {
                        DispatchQueue.main.async { completion(nil) }
                    }
                    
                } else {
                    
                    print("HTTP Error: Status code \(httpResponse.statusCode)")
                    DispatchQueue.main.async { completion(nil) }
                    
                }
                
            } else {
                
                print("Invalid response")
                DispatchQueue.main.async { completion(nil) }
                
            }
            
        }.resume()
        
    }
    
}
