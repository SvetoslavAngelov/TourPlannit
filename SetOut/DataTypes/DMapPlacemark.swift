//
//  DMapRegion.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 28/12/2022.
//

import Foundation
import MapKit

class DMapPlacemark: ObservableObject {
    
    @Published var region = DefaultRegion()
    @Published var name = "Loading..."

    public func updateMapRegion(newRegion: MKCoordinateRegion) -> Void {
        region = newRegion
    }
    
    public func updateMapRegion(newCoordinate: CLLocationCoordinate2D) -> Void {
        region.center.longitude = newCoordinate.longitude
        region.center.latitude = newCoordinate.latitude
    }
}