//
//  ForecastModel.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import Foundation

struct OneCallResponse: Codable {
    let current: CurrentWeather
    let daily: [DailyForecast]
}

struct CurrentWeather: Codable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let weather: [WeatherCondition]
}

struct DailyForecast: Codable {
    let dt: Int
    let temp: Temp
    let feels_like: FeelsLike
    let weather: [WeatherCondition]
}

struct Temp: Codable {
    let min: Double
    let max: Double
}

struct FeelsLike: Codable {
    let day: Double
    let night: Double
}
