//
//  VSearchView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 02/01/2023.
//

import SwiftUI

struct VSearchView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("Search").font(.title3).padding()
            
            HStack(spacing: 10.0){
                CSearchBar()
                CUserLocation()
            }
            CSearchList()
        }
    }
}

struct VSearchView_Previews: PreviewProvider {
    static var previews: some View {
        VSearchView()
            .environmentObject(DNavigationStack())
            .environmentObject(DCardPosition())
            .environmentObject(DLocationManager())
            .environmentObject(DLocationSearch())
            .environmentObject(DMapPlacemark())
    }
}
