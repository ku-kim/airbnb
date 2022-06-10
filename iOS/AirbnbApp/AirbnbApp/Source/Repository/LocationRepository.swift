//
//  LocationRepository.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/08.
//

import Foundation
import CoreLocation

final class LocationRepository: NSObject, CLLocationManagerDelegate {
    
    let loadedLocation = PublishRelay<Coordinate>()
    
    private let locationManager = CLLocationManager()
    private var locations: [CLLocation] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getUserLocation() {
        guard let location = self.locations.last else { return }
        let CLCoordinate = location.coordinate
        let coordinate = Coordinate(lat: CLCoordinate.latitude, lng: CLCoordinate.longitude)
        loadedLocation.accept(coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if self.locations.count == 10 { self.locations.removeAll() }
            self.locations.append(location)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let location = manager.location else { return }
        let CLCoordinate = location.coordinate
        let coordinate = Coordinate(lat: CLCoordinate.latitude, lng: CLCoordinate.longitude)
        loadedLocation.accept(coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
