//
//  WeatherBackgroundMapper.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/07.
//

import Foundation
import SwiftUI
// map id to get respective image based on condition, using forest_sunny as default or fallback image

struct WeatherBackgroundMapper {
    
    static func backgroundImageName(for main: String?) -> String {
        
        guard let main = main else { return "" }
        
        switch main.lowercased() {
        case "rain":
            return "forest_rainy"
        case "clouds":
            return "forest_cloudy"
        case "clear":
            return "forest_sunny"
        case "storm", "thunderstorm":
            return "forest_rainy"
        default:
            return ""
        }
        
    }
    
}

struct WeatherBackgroundColor {
    
    static func backgroundColour(for main: String?) -> Color {
        guard let main = main else { return Color(.white) }
        switch main.lowercased() {
        case "rain":
            return Color(red: 87/255, green: 57/255, blue: 93/255)
        case "clouds":
            return Color(red: 84/255, green: 113/255, blue: 122/255)
        case "clear":
            return Color(red: 71/255, green: 171/255, blue: 47/255)
        case "storm", "thunderstorm":
            return Color(red: 87/255, green: 57/255, blue: 93/255)
        default:
            return Color(.white)
        }
        
    }
    
}
