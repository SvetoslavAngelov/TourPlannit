//
//  DLocationManager.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

/*
    Class used to retrieve the user's latest location.
 */

import Foundation
import MapKit

/*
    Helper class used to find the user's current location.
    Once the Location Manager is initialised it triggers an authorisation update
    and requests the user's location. 
 */
class DLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var locationManager: Optional<CLLocationManager> = CLLocationManager()
    
    @Published var lastCoordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    @Published var lastCoordinateRegion = DefaultRegion()
    
    override init() {
        super.init()
        
        locationManager?.delegate = self
    }
    
    public func requestLastLocation() -> Void {
        if let locationManager {
            locationManager.requestLocation()
        }
    }
    
    private func updateAuthorisationStatus() -> Void {
        
        if let locationManager {
            switch locationManager.authorizationStatus{
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                // TODO
                break
            case .denied:
                // TODO
                break
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
            @unknown default:
                // TODO
                break
            }
        }
    }
    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updateAuthorisationStatus()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last ?? CLLocation(latitude: 0.0, longitude: 0.0)
        
        lastCoordinate.latitude = lastLocation.coordinate.latitude
        lastCoordinate.longitude = lastLocation.coordinate.longitude
        
        lastCoordinateRegion.center.latitude = lastLocation.coordinate.latitude
        lastCoordinateRegion.center.longitude = lastLocation.coordinate.longitude
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("Location manager encountered an error: \(error.localizedDescription). The last fetched location is: \"Latitude\(self.lastCoordinate.latitude.description) and longitude \(self.lastCoordinate.longitude.description)\"")
            }
    }
}
