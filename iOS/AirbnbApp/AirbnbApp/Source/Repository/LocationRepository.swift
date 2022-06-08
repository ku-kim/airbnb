//
//  LocationRepository.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/08.
//

import Foundation
import CoreLocation

final class LocationRepository: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let loadedLocation = PublishRelay<Coordinate>()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        getUserLocation()
    }
    
    func getUserLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let CLCoordinate = location.coordinate
            let coordinate = Coordinate(lat: CLCoordinate.latitude, lng: CLCoordinate.longitude)
            
            loadedLocation.accept(coordinate)
        }
    }
}
