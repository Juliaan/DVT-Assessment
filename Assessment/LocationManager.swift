//
//  LocationManager.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var coordinate: CLLocationCoordinate2D?
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0

    private let manager = CLLocationManager()

    override init() {
        
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let latestLocation = locations.first {
            
            self.coordinate = latestLocation.coordinate
            
        }
        
        manager.stopUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Handle error : \(error.localizedDescription)")
    }
    
}
