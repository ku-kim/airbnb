//
//  Coordinate.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/01.
//

import Foundation
import CoreLocation

struct Coordinate {
    var lat: Double
    var lng: Double
    
    func converToCLLocation() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
