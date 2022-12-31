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
    @EnvironmentObject var mapRegion: DMapRegion
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
            .onChange(of: mapRegion.region) {_ in
                withAnimation(.easeInOut(duration: 4.0)){
                    region = mapRegion.region
                }
            }
    }
}

struct CMapView_Previews: PreviewProvider {
    static var previews: some View {
        CMapView().environmentObject(DMapRegion())
    }
}
