//
//  LocationService.swift
//  Weather
//
//  Created by Tanya Samastroyenka on 17.11.2021.
//

import Foundation
import CoreLocation

class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    var lat, lon: Double?
    
    var didUpdatedLocation: (() -> ())?
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            
            didUpdatedLocation?()
        }
    }
}
