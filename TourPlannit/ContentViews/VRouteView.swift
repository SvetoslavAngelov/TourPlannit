//
//  VRouteView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI
import MapKit

struct VRouteView: View {
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 10.0){
            
            Text("Options").font(.title3).padding()
            CRouteOptions()
            Text("Top Attractions").font(.title3).padding()
            
            ScrollView{
                ForEach(touristAttractions) { result in
                    RTouristAttractionRow(touristAttraction: result)
                }
            }.frame(width: 360.0, height: 360.0)
        }
    }
}

struct VRouteView_Previews: PreviewProvider {
    static var previews: some View {
        VRouteView()
    }
}
