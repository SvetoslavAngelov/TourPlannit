//
//  VRouteView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI

struct VRouteView: View {
    var body: some View{
        ZStack{
                GeometryReader{ screen in
                    CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .top, cardPosition: .middle){
                    VStack(alignment: .leading, spacing: 10.0){
                        Text("Options").font(.title3).padding()
                        CRouteOptions()
                        Text("Top Attractions").font(.title3).padding()
                        RTouristAttractionRow(touristAttraction: touristAttractions[0])
                        RTouristAttractionRow(touristAttraction: touristAttractions[1])
                        RTouristAttractionRow(touristAttraction: touristAttractions[2])
                        RTouristAttractionRow(touristAttraction: touristAttractions[3])
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

struct VRouteView_Previews: PreviewProvider {
    static var previews: some View {
        VRouteView()
    }
}
