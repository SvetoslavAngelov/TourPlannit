//
//  VMainView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 06/12/2022.
//

import SwiftUI
import MapKit

struct VMainView: View {
    
    // The position at which the main sliding card component
    // is snapped to - bottom, middle or top of screen.
    @EnvironmentObject var slidingCardPosition: DCardPosition
    
    // The location manager requests access to the user's location
    // and then provides the user's location upon request.
    @EnvironmentObject var locationManager: DLocationManager
    
    // The map region is the area where the Map View component is
    // centred at. It can be set to the user's location or to a
    // specific point of interest on the map set by the user.
    @EnvironmentObject var mapRegion: DMapRegion
    
    @State var searchText = ""
    
    var body: some View {
        
        ZStack {
            CMapView().preferredColorScheme(.light)
            
            GeometryReader{ screen in
                CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .top){
                   
                    VStack(alignment: .leading, spacing: 10.0){
                        CSearchBar()
                        CSearchList()
                    }
                }
            }.edgesIgnoringSafeArea(.bottom)
        }.onChange(of: locationManager.lastCoordinateRegion) {_ in
            mapRegion.region = locationManager.lastCoordinateRegion
        }
    }
    
    private func moveToMiddle() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            slidingCardPosition.updatePosition(newPosition: .middle)
        }
    }
    
    private func requestLocation() -> Void {
        mapRegion.region = locationManager.lastCoordinateRegion
        locationManager.requestLastLocation()
    }
    
    private func changeLocation() -> Void {
        mapRegion.region = DefaultRegion()
    }
}

struct VMainView_Previews: PreviewProvider {
    static var previews: some View {
        VMainView()
            .environmentObject(DCardPosition())
            .environmentObject(DLocationManager())
            .environmentObject(DMapRegion())
    }
}
