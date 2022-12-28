//
//  TourPlannitApp.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI
import MapKit

@main
struct TourPlannitApp: App {
    
    @StateObject var slidingCardPosition = DCardPosition()
    
    var body: some Scene {
        WindowGroup {
            VMainView().environmentObject(slidingCardPosition)
        }
    }
}
