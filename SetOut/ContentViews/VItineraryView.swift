//
//  VResultsView .swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 20/11/2022.
//

import SwiftUI

/*
    A view with the generated itinerary presented to the user. 
 */
struct VResultsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0){
            
            Text("Top Attractions").font(.title3).padding()
            
            ScrollView{
                ForEach(touristAttractions) { result in
                    RTouristAttractionRow(touristAttraction: result)
                }
            }.frame(width: 360.0, height: 560.0)
        }
    }
}

struct VResultsView_Previews: PreviewProvider {
    static var previews: some View {
        VResultsView()
    }
}
