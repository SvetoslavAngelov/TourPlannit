//
//  DLocationSearch.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 06/11/2022.
//

import Foundation
import SwiftUI
import MapKit
import Combine

/*
    Helper class which returns address location results based on partial search querries.
    Upon a successful search query, the searchCompletion property returns a list of
    strings which can then be used to perform a map search using Apple's MapKit API.
 */
class DLocationSearch: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    
    @Published var searchQuery = ""
    var searchCompletion: [MKLocalSearchCompletion] = []
    
    var mapPlacemark: Optional<MKPlacemark> = nil
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var cancellable: AnyCancellable?
    
    // Constrain the search completion to a specific region
    init(_ region: MKCoordinateRegion = DefaultRegion()) {
        super.init()
        
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .pointOfInterest
        searchCompleter.region = region
        
        // Assign the search query to the MKLocalSearchCompleter
        cancellable = $searchQuery.assign(to: \.queryFragment, on: self.searchCompleter)
    }
    
    func clearSearchQuerry() -> Void {
        self.searchQuery = ""
        self.searchCompletion = []
    }
    
    // Initiate a map search using fully formed address strings provided by the search completion object
    func startSearch(_ completion: MKLocalSearchCompletion, _ region: MKCoordinateRegion = DefaultRegion()) -> Void {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        
        // Takes an optional region to narrow the address search to a specific region
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let placemark = response?.mapItems[0].placemark else {
                return
            }
            
            self.mapPlacemark = placemark
        }
    }
    
    // Set the search completion array to empty if the search querry is empty or an error is captured
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(self.searchCompleter.queryFragment)\"")
        }
        
        // Clear the last search completion list
        self.searchCompletion = []
    }
    
    // Runs every time a new set of results is returned by the MapKit API when the search querry is modified
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchCompletion = searchCompleter.results
    }
}

extension DLocationSearch: Identifiable {
    
}
