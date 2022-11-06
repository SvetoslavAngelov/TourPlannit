//
//  VRootView .swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 08/10/2022.
//

import SwiftUI
import MapKit

enum NavigationStack {
    case Search
    case Route
    case Results
}

struct VRootView: View {
    
    /*
        Root view properties
     */
    @StateObject var userLocation = DLocationManager()
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
    
    /*
        Generated route
     */
    
    var body: some View {
        
        ZStack{
            Map(coordinateRegion: $userLocation.lastCoordinateRegion, showsUserLocation: true).ignoresSafeArea().preferredColorScheme(.light)
            
            GeometryReader{ screen in
                CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .bottom, cardPosition: .bottom, action: resetFocus){
  
                    Button("switch", action: switchView).padding(.top)
                    
                    /*
                        Search section
                     */
                    VStack{
                        CSearchBar(isFocused: $isFocused, searchText: $locationSearch.searchQuery)
                        
                        List(locationSearch.searchCompletion, id: \.self) { location in
                            VStack(alignment: .leading) {
                                Text(location.title)
                                Text(location.subtitle)
                                    .font(.system(.caption))
                            }
                        }
                        
                        // Search results
                    }.offset(x: navigationStack == .Search ? 0.0 : screen.size.width)
                    
                    /*
                        Route section
                     */
                    VRouteView().offset(x: navigationStack == .Route ? 0.0 : screen.size.width)
                    
                    /*
                        Results section
                     */
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
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
