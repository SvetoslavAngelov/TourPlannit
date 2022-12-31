//
//  TourPlannitApp.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI

@main
struct TourPlannitApp: App {
    
    // The position of the main sliding card component
    @StateObject var slidingCardPosition = DCardPosition()
    
    // Object which manages the user's location
    @StateObject var locationManager = DLocationManager()
    
    // Object which stores user search queries for points
    // of interest and triggers location search via Map Kit's API.
    @StateObject var locationSearch = DLocationSearch()
    
    // The region on which the map is centred,
    // it could be the user's location or a user specified location
    @StateObject var mapRegion = DMapRegion()
    
    var body: some Scene {
        WindowGroup {
            VMainView()
                .environmentObject(slidingCardPosition)
                .environmentObject(locationManager)
                .environmentObject(locationSearch)
                .environmentObject(mapRegion)
        }
    }
}
