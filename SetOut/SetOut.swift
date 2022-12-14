//
//  TourPlannitApp.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI

@main
struct SetOutApp: App {
    
    // Custom navigation stack, used to switch between the
    // three main sub views in the app:
    // 1. Search view - user can set a start location of the route
    // 2. Options view - specify route options
    // 3. Itinerary view - the generated route
    @StateObject var navigationStack = DNavigationStack()
    
    // The position of the main sliding card component
    // which is used to host all of the three main subviews (see above)
    @StateObject var slidingCardPosition = DCardPosition()
    
    // A custom location manager, which is used to request the user's
    // current location. This object does not track the user location.
    @StateObject var locationManager = DLocationManager()
    
    // Helper object which is used to trigger map API searches,
    // provides search completion suggestions and returns a map
    // object upon a successful search querry.
    @StateObject var locationSearch = DLocationSearch()
    
    // The user's current location provided by the location manager
    // or a new map location provided by the location search object
    // upon a successful search querry. 
    @StateObject var mapPlacemark = DMapPlacemark()
    
    var body: some Scene {
        WindowGroup {
            VMainView()
                .environmentObject(navigationStack)
                .environmentObject(slidingCardPosition)
                .environmentObject(locationManager)
                .environmentObject(locationSearch)
                .environmentObject(mapPlacemark)
        }
    }
}
