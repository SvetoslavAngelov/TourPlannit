//
//  CMapView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 06/12/2022.
//

import SwiftUI
import MapKit

struct CMapView: View {
    @State var region = DefaultRegion()
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
    }
    
    func updateRegion(newRegion: MKCoordinateRegion) -> Void {
        region = newRegion
    }
}

struct CMapView_Previews: PreviewProvider {
    static var previews: some View {
        CMapView()
    }
}
