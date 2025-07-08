//
//  LoadingView.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/07.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        
        VStack {
        
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle (tint: .white))
            
            Text("loading ...")
            
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.106, green: 0.41, blue: 0.59))
        
    }
    
}

#Preview {
    LoadingView()
}
