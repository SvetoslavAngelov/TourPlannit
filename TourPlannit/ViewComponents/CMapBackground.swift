//
//  CMapBackground.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 21/09/2022.
//

import SwiftUI
import MapKit

struct CMapBackground: View {
    private var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    
    init(coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .onAppear {
                setRegion(coordinate)
            }   .ignoresSafeArea()
                .preferredColorScheme(.light)
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) -> Void {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    }
}

struct CMapBackground_Previews: PreviewProvider {
    static var previews: some View {
        CMapBackground(coordinate: CLLocationCoordinate2D(latitude: 51.476833, longitude: -0.000536))
    }
}
