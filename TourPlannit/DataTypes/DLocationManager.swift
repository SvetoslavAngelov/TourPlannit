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

class DLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var locationManager: Optional<CLLocationManager> = CLLocationManager()
    
    // 0 coordinates to identify an error quicker.
    @Published var lastCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
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
        
        lastCoordinateRegion.center.latitude = lastLocation.coordinate.latitude
        lastCoordinateRegion.center.longitude = lastLocation.coordinate.longitude
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
