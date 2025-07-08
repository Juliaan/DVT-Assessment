//
//  LocationView.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/08.
//

import SwiftUI
import CoreLocationUI

struct LocationSettingsView: View {
    
    var body: some View {
        
        VStack {
            
            VStack(spacing: 20) {
    
                Text("DVT Weather App Assessment").bold().font(.title)
                
                Text("For the purpose of this assessment to work, please share your location so we can display weather data for your area.").padding()
                
            }
            .multilineTextAlignment(.center)
            .padding()
            
            Button(action: {
                
                // open settings app
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    UIApplication.shared.open(url)
                    
                }
                
            }) {
                Text("Open Settings")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 250, height: 48)
                .background(Color.blue)
                .cornerRadius(8)
            }
            
            Spacer()
            
            Text("Created by Juliaan Evenwel.").padding()
            
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.106, green: 0.41, blue: 0.59))
        
    }
    
}

#Preview {
    LocationSettingsView()
}
