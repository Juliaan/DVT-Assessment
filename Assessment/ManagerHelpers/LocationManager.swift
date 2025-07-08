//
//  LocationManager.swift
//  Assessment
//
//  Created by Juliaan Evenwel on 2025/07/06.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationPermissionEnabled = false
    @Published var locationIsUpdating = false
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0

    private let manager = CLLocationManager()

    override init() {
        
        super.init()
        
        manager.delegate = self
        
        startLocationUpdates()
        
    }

    func startLocationUpdates() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // use best location
        if let newLocation = locations.first {
            
            self.coordinates = newLocation.coordinate
            
        }
        
        manager.stopUpdatingLocation()
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // check auth status
        if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
            
            locationPermissionEnabled = true
            
        } else {
            
            locationPermissionEnabled = false
            
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : \(error.localizedDescription)")
    }
    
}
