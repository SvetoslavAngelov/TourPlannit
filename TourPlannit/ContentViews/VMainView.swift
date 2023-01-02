//
//  VMainView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 06/12/2022.
//

import SwiftUI
import MapKit

struct VMainView: View {
    
    @EnvironmentObject var navigationStack: DNavigationStack
    
    var body: some View {
        
        ZStack {
            CMapView().preferredColorScheme(.light)
            
            GeometryReader{ screen in
                CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .top){
                    
                    switch navigationStack.stack {
                    case .searchView:
                        VSearchView()
                    case .optionsView:
                        VOptionsView()
                    case .itineraryView:
                        VOptionsView()
                    }
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct VMainView_Previews: PreviewProvider {
    static var previews: some View {
        VMainView()
            .environmentObject(DNavigationStack())
            .environmentObject(DCardPosition())
            .environmentObject(DLocationManager())
            .environmentObject(DLocationSearch())
            .environmentObject(DMapPlacemark())
    }
}
