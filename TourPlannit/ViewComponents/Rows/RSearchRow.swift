//
//  RSearchRow.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 19/09/2022.
//

import SwiftUI
import MapKit

struct RSearchRow: Identifiable, View {
        
    var id = UUID()
    private var name: String
    private var place: String
    
    init(mapItem: MKMapItem) {
        name = mapItem.name ?? ""
        place = mapItem.placemark.name ?? ""
    }
    
    var body: some View {
        VStack{
            Text(name).font(.title2)
            Text(place).font(.title3)
        }
    }
}
