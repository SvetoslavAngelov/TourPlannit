//
//  DSearchRequest.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 26/10/2022.
//
import SwiftUI
import Combine
import MapKit

class DSearchRequest : NSObject, ObservableObject {
    @Published var locationResults : [MKLocalSearchCompletion] = []
    @Published var searchText = ""
    
    private var cancellables : Set<AnyCancellable> = []
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var promise : ((Result<[MKLocalSearchCompletion], Error>) -> Void)?
    
    override init() {
        super.init()
        
        searchCompleter.delegate = self
    }
    
    func startSearch(_ searchRegion: MKCoordinateRegion = DefaultRegion()) -> Void {
        searchCompleter.resultTypes = .pointOfInterest
        searchCompleter.region = searchRegion
        
        $searchText
            .removeDuplicates()
            .flatMap({ (currentSearchTerm) in
                self.searchTermToResults(searchTerm: currentSearchTerm)
            })
            .sink(receiveCompletion: { (completion) in
                // TODO on completion
            }, receiveValue: { (results) in
                self.locationResults = results
            })
            .store(in: &cancellables)
    }
    
    func stopSearch() -> Void {
        locationResults.removeAll()
    }
    
    private func searchTermToResults(searchTerm: String) -> Future<[MKLocalSearchCompletion], Error> {
        Future { promise in
            self.searchCompleter.queryFragment = searchTerm
            self.promise = promise
        }
    }
}

extension DSearchRequest : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            promise?(.success(completer.results))
        }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription). The query fragment is: \"\(self.searchCompleter.queryFragment)\"")
            }
    }
}
