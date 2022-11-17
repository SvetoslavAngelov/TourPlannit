//
//  DLocationManager.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import Foundation
import MapKit

/*
    Helper class used to find the user's current location.
    Once the Location Manager is initialised it triggers an authorisation update
    and requests the user's location. 
 */
class DLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private var locationManager: Optional<CLLocationManager> = CLLocationManager()
    @Published var lastCoordinateRegion = DefaultRegion()
    
    var didChange = false
    
    override init() {
        super.init()
        
        locationManager?.delegate = self
    }
    
    public func requestLastLocation() -> Void {
        if let locationManager {
            locationManager.requestLocation()
        }
    }
    
    public func getLastCoordinateRegion() -> MKCoordinateRegion {
        return self.lastCoordinateRegion
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
        
        didChange.toggle()
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("Location manager encountered an error: \(error.localizedDescription). The last fetched location is: \"Latitude\(self.lastCoordinateRegion.center.latitude.description) and longitude \(self.lastCoordinateRegion.center.longitude.description)\"")
            }
    }
}
