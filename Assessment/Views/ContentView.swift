//
//  ContentView.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/07.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        
        let backgroundName = WeatherBackgroundMapper.backgroundImageName(
            for: viewModel.weatherMain)
        let backgroundColor = WeatherBackgroundColor.backgroundColour(for: viewModel.weatherMain)

        VStack(spacing: 0) {
        
            ZStack {
                Image(backgroundName)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .aspectRatio(contentMode: .fill)
                VStack {
                    
                    Text(viewModel.cityName)
                        .font(.largeTitle)
                        .bold()
                    
                    Text("\(Int(viewModel.temperature))°C")
                        .font(.system(size: 72))
                        .bold()
                    
                }
            }
            .foregroundColor(.white)
            
            HStack {

                /*
                    - openweather api returns the same temp for min and max
                 */
                
                Text("\(Int(viewModel.tempMin))°C")
                    .padding(.leading, 16)
                    .padding(.top, 8)
                Spacer()
                Text("\(Int(viewModel.feelsLike))°C")
                    .padding(.top, 8)
                Spacer()
                Text("\(Int(viewModel.tempMax))°C").padding(.trailing, 16)
                    .padding(.top, 8)
                    
            }
            .background(backgroundColor)
            .foregroundColor(.white)
            
            HStack {
                Text("Min")
                    .padding(.leading, 16)
                    .padding(.bottom, 8)
                Spacer()
                Text("Feels like")
                    .padding(.bottom, 8)
                Spacer()
                Text("Max").padding(.trailing, 16)
                    .padding(.bottom, 8)
            }
            .background(backgroundColor)
            .foregroundColor(.white)

            
            //.padding()
            
            Divider()
            VStack {
            
                ScrollView {
                    // 6 day forecast
                    Text("Forecast")
                        .font(.headline)
                        .padding(.top, 8)
                    
                    ForEach(viewModel.forecast.dropFirst(), id: \.dt) { dayForecast in
                                        HStack {
                                            // Date
                                            Text(dateString(from: dayForecast.dt))
                                                .frame(width: 150, alignment: .leading)
                                                .padding(.leading, 16)
                                                .padding(.bottom, 8)
                                            Spacer()
                                            // Weather icon placeholder
                                            
                                            Image(systemName: WeatherIconMapper.systemImageName(for: dayForecast.weather.first?.icon ?? "01d"))
                                            
                                            
                                            Spacer()
                                            // Min / Max
                                            Text("\(Int(dayForecast.temp.min))° / \(Int(dayForecast.temp.max))°")
                                                .frame(width: 100, alignment: .trailing)
                                                .padding(.trailing, 16)
                                        }
                                    }
                    
                }
                .background(backgroundColor)
                .foregroundColor(.white)
                
            }
        }
        
    }
    
    private func dateString(from timestamp: Int) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEEE"
        
        return formatter.string(from: date)
        
    }
    
}

#Preview {
    ContentView()
}
