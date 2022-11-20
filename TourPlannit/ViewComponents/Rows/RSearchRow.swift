//
//  RSearchRow.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 19/09/2022.
//

import SwiftUI
import MapKit

struct RSearchRow: View {
    
    private var locationTitle: String
    private var locationSubtitle: String
    
    init(locationItem: MKLocalSearchCompletion) {
        self.locationTitle = locationItem.title
        self.locationSubtitle = locationItem.subtitle
    }
    
    init(title: String, subtitle: String) {
        self.locationTitle = title
        self.locationSubtitle = subtitle
    }
    
    var body: some View {
        
        ZStack(alignment: .leading){
            STransparentCard(width: 360.0, height: 60.0)
                .cornerRadius(10.0)
            
            VStack(alignment: .leading, spacing: 10.0){
                Text(locationTitle).font(.headline)
                Text(locationSubtitle).font(.subheadline)
            }.padding(.leading)
        }
    }
}

struct RSearchRow_Previews: PreviewProvider {
    static var previews: some View {
        RSearchRow(title: "Royal Observatory Greenwich", subtitle: "Address")
    }
}
