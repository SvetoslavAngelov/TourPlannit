//
//  VSearchView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI
import MapKit

struct VSearchView: View {
    @StateObject var locationManager = DLocationManager()
    @State var searchLocation = ""
    @FocusState var isFocused : Bool

    var body : some View {
        
        ZStack{
            Map(coordinateRegion: $locationManager.lastCoordinateRegion, showsUserLocation: true)
                .ignoresSafeArea()
                .preferredColorScheme(.dark)
            GeometryReader{ screen in
                CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .top, cardPosition: .middle, action: resetFocus){
                    VStack(alignment: .leading, spacing: 10.0){
                        Text("Start Location").font(.title3).padding()
                        
                        searchField
                        
                        Text("Popular Routes").font(.title3).padding()
                    }
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var searchField : some View {
        ZStack{
            STransparentCard(width: 360.0, height: 100.0, color: Color(red: 0.43, green: 0.43, blue: 0.43, opacity: 1.0))
                .cornerRadius(20.0)
                .shadow(color: .gray, radius: 1.0)
            
            HStack(){
                Text("\(Image(systemName: "magnifyingglass"))").foregroundColor(.gray)
                TextField("Set a start location...", text: $searchLocation)
                    .frame(width: 180.0, height: 50.0, alignment: .leading)
                    .focused($isFocused)
                Button("Cancel",action: cancelSearch)
                Button("\(Image(systemName: "location.circle"))", action: requestLastLocation).font(.title2).padding()
            }
        }
    }
    
    private func cancelSearch() -> Void {
        searchLocation = ""
        isFocused = false
    }
    
    private func requestLastLocation() -> Void {
        locationManager.requestLastLocation()
    }

    private func resetFocus() -> Void {
        isFocused = false
    }
}

struct VSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VSearchView()
    }
}
