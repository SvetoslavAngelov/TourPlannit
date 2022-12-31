//
//  CSearchList.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 30/12/2022.
//

import SwiftUI
import MapKit

struct CSearchList: View {
    
    // The location search allows the user to search for specific
    // points of interest on the map and retuns a map object upon
    // successful search request.
    @EnvironmentObject var locationSearch: DLocationSearch
    
    @State var searchResults: [MKLocalSearchCompletion] = []
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10.0){
            
            ForEach(searchResults.prefix(5), id: \.self) { location in
                Button {
                    locationSearch.startSearch(location)
                } label: {
                    RSearchRow(locationItem: location)
                }.buttonStyle(.plain)
            }
        }.frame(width: 360.0)
            .onChange(of: locationSearch.searchCompletion) {_ in
                searchResults = locationSearch.searchCompletion
            }
    }
}

struct CSearchList_Previews: PreviewProvider {
    static var previews: some View {
        CSearchList().environmentObject(DLocationSearch())
    }
}
