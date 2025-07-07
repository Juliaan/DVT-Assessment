//
//  ContentView.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        
        //ContentView()
        LoadingView()
    }
    
}

#Preview {
    MainView()
}
