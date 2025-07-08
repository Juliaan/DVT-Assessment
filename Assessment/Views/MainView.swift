//
//  ContentView.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        
        // check if location is enabled
        if locationManager.locationPermissionEnabled {
            
            // check if we are loading
            if viewModel.isLoading {
                
                LoadingView()
                
            } else {
                
                ContentView()
                
            }
            
        } else {
            
            // show settings view because we need location
            LocationSettingsView()
            
        }
        
    }
    
}

#Preview {
    MainView()
}
