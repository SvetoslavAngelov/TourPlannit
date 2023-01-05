//
//  CMapView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 06/12/2022.
//

import SwiftUI
import MapKit

/*
    A simple Map view, which centres on the mapRegion environment
    variable. The mapRevion variable can be set by the user to either
    their current location, or other point of interest on the map.
 */

struct CMapView: View {
    @State var region = DefaultRegion()
    
    // The map placemark is the area where the Map View component is
    // centred at. It can be set to the user's location or to a
    // specific point of interest on the map set by the user.
    @EnvironmentObject var mapPlacemark: DMapPlacemark
    
    // The location manager requests access to the user's location
    // and then provides the user's location upon request.
    @EnvironmentObject var locationManager: DLocationManager
    
    @EnvironmentObject var locationSearch: DLocationSearch
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
            .onChange(of: mapPlacemark.region) {_ in
                withAnimation(.easeInOut(duration: 4.0)){
                    region = mapPlacemark.region
                }
            }.onChange(of: locationManager.lastCoordinateRegion) {_ in
                withAnimation(.easeInOut(duration: 4.0)){
                    mapPlacemark.region = locationManager.lastCoordinateRegion
                    mapPlacemark.name = "Current Location"
                }
            }.onChange(of: locationSearch.mapPlacemark) {_ in
                withAnimation(.easeInOut(duration: 4.0)){
                    mapPlacemark.region = MKCoordinateRegion(
                        center: locationSearch.mapPlacemark?.coordinate ?? CLLocationCoordinate2D(latitude: 51.476833, longitude: -0.000536),
                        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
                    mapPlacemark.name = locationSearch.mapPlacemark?.name ?? "Loading"
                }
            }
    }
}

struct CMapView_Previews: PreviewProvider {
    static var previews: some View {
        CMapView()
            .environmentObject(DMapPlacemark())
            .environmentObject(DLocationManager())
            .environmentObject(DLocationSearch())
    }
}
