//
//  VRootView .swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 08/10/2022.
//

import SwiftUI
import MapKit

/*
    The root view which assembles all other views and components. It leads the user
    through a three stage process:
    1. Set a start location by using user's location or a custom address.
    2. Set the route parameters, including the time available to visit and the distance to cover.
    3. Review the results based on the route parameters and select the final itinerary.
 */
enum NavigationStack {
    case Search
    case Route
    case Results
}

struct VRootView: View {
    
    /*
     Root view properties
     */
    @StateObject var locationManager = DLocationManager()
    @State var userCoordinateRegion = DefaultRegion()
    
    @State private var isAnimating = false
    @State private var navigationStack = NavigationStack.Search
    
    /*
     Search section
     */
    @FocusState var isFocused: Bool
    @StateObject var locationSearch = DLocationSearch()
    
    /*
     Route options
     */
    @State var searchQuery: String = ""
    
    /*
     Generated route
     */
    
    var body: some View {
        
        ZStack{
            Map(coordinateRegion: $userCoordinateRegion, showsUserLocation: true).ignoresSafeArea().preferredColorScheme(.light)
            
            GeometryReader{ screen in
                CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .top, cardPosition: .bottom, action: resetFocus){
                    /*
                     Search section
                     */
                    VStack{
                        CSearchBar(isFocused: $isFocused, searchText: $searchQuery)
                        
                        ScrollView{
                            ForEach(locationSearch.searchCompletion, id: \.self) { location in
                                Button {
                                    locationSearch.startSearch(location)
                                    switchView()
                                } label: {
                                    RSearchRow(locationItem: location)
                                }.buttonStyle(.plain)
                            }
                        }.frame(width: 360.0, height: 480.0)
                    }.offset(x: navigationStack == .Search ? 0.0 : screen.size.width)
                    
                    /*
                     Route section
                     */
                    VStack(alignment: .leading){
                        Text("Start Location").font(.title3).padding()
                        VRouteView()
                    }.offset(x: navigationStack == .Route ? 0.0 : screen.size.width)
                }
            }.edgesIgnoringSafeArea(.bottom)
        }.onChange(of: locationManager.didChange) {_ in
            userCoordinateRegion = locationManager.getLastCoordinateRegion()
        }.onChange(of: searchQuery) {_ in
            locationSearch.searchQuery = searchQuery
        }.onChange(of: locationSearch.didChange){_ in
            userCoordinateRegion = locationSearch.getPlacemarkCoordinateRegion()
        }
        
        // TODO set location if device is offline
    }
    
    private func switchView() -> Void {
        isFocused = false
        navigationStack = .Route
    }
    
    private func resetFocus() -> Void {
        self.isFocused = false
        self.locationSearch.clearSearchQuerry()
    }
}

struct VRootView_Previews: PreviewProvider {
    
    static var previews: some View {
        VRootView()
    }
}
