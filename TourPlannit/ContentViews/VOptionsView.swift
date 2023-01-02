//
//  VRouteView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI
import MapKit

struct VOptionsView: View {

    @EnvironmentObject var navigationStack: DNavigationStack
    @EnvironmentObject var slidingCardPosition: DCardPosition
    @EnvironmentObject var mapPlacemark: DMapPlacemark
    
    @State var startLocationName = "Loading..."
    
    var body: some View{
        
        VStack(alignment: .leading, spacing: 10.0){
            Text("Start Location").font(.title3).padding()
            
            HStack(spacing: 10.0){
                Text(startLocationName).frame(width: 320.0)
                
                Button {
                    returnToSearchView()
                } label: {
                    Text("\(Image(systemName: "x.circle.fill"))").font(.title)
                }
            }

            
            Text("Options").font(.title3).padding()
            CRouteOptions()
            Text("Top Attractions").font(.title3).padding()
            
            ScrollView{
                ForEach(touristAttractions) { result in
                    RTouristAttractionRow(touristAttraction: result)
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
