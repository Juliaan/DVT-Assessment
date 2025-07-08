//
//  Models.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [WeatherCondition]
    let coord: Coordinates
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct WeatherCondition: Codable {
    let id: Int
    let description: String
    let icon: String
    let main: String
}

struct Coordinates: Codable {
    let lat: Double
    let lon: Double
}

struct WeatherIconMapper {
    
    static func systemImageName(for iconCode: String) -> String {
        
        switch iconCode {
        case "01d": // clear sky day
            return "sun.max.fill"
        case "01n": // clear sky night
            return "moon.stars.fill"
        case "02d": // few clouds day
            return "cloud.sun.fill"
        case "02n": // few clouds night
            return "cloud.moon.fill"
        case "03d", "03n": // scattered clouds
            return "cloud.fill"
        case "04d", "04n": // broken clouds
            return "smoke.fill"
        case "09d", "09n": // shower rain
            return "cloud.rain.fill"
        case "10d": // rain day
            return "cloud.sun.rain.fill"
        case "10n": // rain night
            return "cloud.moon.rain.fill"
        case "11d", "11n": // thunderstorm
            return "cloud.bolt.fill"
        case "13d", "13n": // snow
            return "snow"
        case "50d", "50n": // mist
            return "cloud.fog.fill"
        default:
            return "cloud.fill"
        }
        
    }
    
}
