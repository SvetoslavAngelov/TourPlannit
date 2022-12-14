//
//  CUserLocation.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 02/01/2023.
//

import SwiftUI

struct CUserLocation: View {
    
    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var locationManager: DLocationManager
    @EnvironmentObject var mapPlacemark: DMapPlacemark
    
    var body: some View {
        Button{
            requestLocation()
            navigateToOptions()
        } label: {
            Text("\(Image(systemName: "location"))")
                .frame(width: 30.0)
                .font(.title2)
        }.buttonStyle(.borderedProminent)
develop:SetOut/ViewComponents/CUserLocation.swift
    }
    
    private func requestLocation() -> Void {
        let lastUserLocation = locationManager.lastCoordinateRegion
        locationManager.requestLastLocation()
        
        if lastUserLocation == locationManager.lastCoordinateRegion{
            
            // move the map view back to the user's original location.
            mapPlacemark.updateMapRegion(newRegion: locationManager.lastCoordinateRegion)
develop:SetOut/ViewComponents/CUserLocation.swift
            mapPlacemark.name = "Current Location"
        }
    }
    
    private func navigateToOptions() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            navigationStack.navigateTo(.optionsView)
develop:SetOut/ViewComponents/CUserLocation.swift
        }
    }
}

struct CUserLocation_Previews: PreviewProvider {
    static var previews: some View {
        CUserLocation()
            .environmentObject(DNavigationStack())
            .environmentObject(DLocationManager())
            .environmentObject(DMapPlacemark())
    }
}
