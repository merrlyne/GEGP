//
//  LocationsController.swift
//  GEGP
//
//  Created by Eric Fry on 4/26/17.
//  Copyright © 2017 Eric Fry. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class LocationsController: NSObject, CLLocationManagerDelegate {
    
    static var currentLocation:CLLocation? = nil
    static let locationManager:CLLocationManager = CLLocationManager()
    static let sharedLocationController:LocationsController = LocationsController()
    
    class func startGPS() {
        locationManager.delegate = sharedLocationController
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    class func stopGPS() {
        locationManager.stopUpdatingLocation()
    }
    
    class func deviceLocation() -> CLLocationCoordinate2D {
        //return CLLocationCoordinate2DMake(33.24104760000001, -95.91037599999999)
        if(currentLocation != nil) {
            return (currentLocation?.coordinate)!
        }
        else {
            return CLLocationCoordinate2DMake(0.0, 0.0)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            manager.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
//        default:
//            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        LocationsController.currentLocation = locations.last
    }
}
