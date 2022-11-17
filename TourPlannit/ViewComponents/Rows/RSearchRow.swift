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
        
        ZStack(alignment: .center){
            STransparentCard(width: 360.0, height: 80.0)
                .cornerRadius(10.0)
            
            VStack(alignment: .leading){
                HStack(spacing: 10.0){
                    Text("\(Image(systemName: "magnifyingglass"))").foregroundColor(.gray)
                    Text(locationTitle).font(.title3)
                }
                Text(locationSubtitle).font(.subheadline)
                Rectangle().frame(width: 340.0, height: 1.0).foregroundColor(.gray)
            }
        }
    }
}

struct RSearchRow_Previews: PreviewProvider {
    static var previews: some View {
        RSearchRow(title: "Royal Observatory Greenwich", subtitle: "Address")
    }
}
