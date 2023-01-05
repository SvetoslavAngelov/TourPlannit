//
//  VRouteView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI
import MapKit

/*
    The options view allows users to specify additional parameters
    which are used to build the final itinerary (route), including:
    1. Time available
    2. Distance to cover
    3. Tourist attractions to include in the itinerary
 */
struct VOptionsView: View {

    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var slidingCardPosition: DCardPosition
    @EnvironmentObject var mapPlacemark: DMapPlacemark
    
    @State var startLocationName = "Loading..."
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 10.0){
            Text("Start Location").font(.title3).padding()
            
            HStack(alignment: .center, spacing: 10.0){
                Text(startLocationName)
                    .frame(width: 300.0, alignment: .leading)
                    .font(.subheadline)
                    .bold()
                    .padding(.leading)
                
                Button {
                    returnToSearchView()
                } label: {
                    Text("\(Image(systemName: "x.circle.fill"))").font(.title2)
                }
            }

            
            Text("Options").font(.title3).padding()
            CRouteOptions()
            Text("Top Attractions").font(.title3).padding()
            
            ScrollView{
                ForEach(touristAttractions) { result in
                    //RTouristAttractionRow(touristAttraction: result)
                    RAttractionRow(touristAttraction: result)
                }
            }.frame(width: 360.0, height: 420.0)
        }.onAppear{
            startLocationName = mapPlacemark.name
            slidingCardPosition.updatePosition(newPosition: .bottom)
        }.onChange(of: mapPlacemark.name) {_ in
            startLocationName = mapPlacemark.name
        }
    }
    
    private func returnToSearchView() -> Void {

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            navigationStack.stack = .searchView
        }
    }
}

struct VOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        VOptionsView()
            .environmentObject(DNavigationStack())
            .environmentObject(DMapPlacemark())
            .environmentObject(DCardPosition())
    }
}
