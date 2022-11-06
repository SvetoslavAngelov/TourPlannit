//
//  VSearchView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI
import MapKit

struct VSearchView: View {
    @StateObject private var mapSearch = DSearchRequest()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Address", text: $mapSearch.searchText)
                }
                Section {
                    ForEach(mapSearch.locationResults, id: \.self) { location in
                        NavigationLink(destination: Detail(locationResult: location)) {
                            VStack(alignment: .leading) {
                                Text(location.title)
                                Text(location.subtitle)
                                    .font(.system(.caption))
                            }
                        }
                    }
                }
            }.navigationTitle(Text("Address search"))
        }
    }
}

class DetailViewModel : ObservableObject {
    @Published var isLoading = true
    @Published private var coordinate : CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.476833, longitude: -0.000536),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    var coordinateForMap : CLLocationCoordinate2D {
        coordinate ?? CLLocationCoordinate2D()
    }
    
    func reconcileLocation(location: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: location)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if error == nil, let coordinate = response?.mapItems.first?.placemark.coordinate {
                self.coordinate = coordinate
                self.region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                self.isLoading = false
            }
        }
    }
    
    func clear() {
        isLoading = true
    }
}

struct Detail : View {
    var locationResult : MKLocalSearchCompletion
    @StateObject private var viewModel = DetailViewModel()
    
    struct Marker: Identifiable {
        let id = UUID()
        var location: MapMarker
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                Text("Loading...")
            } else {
                Map(coordinateRegion: $viewModel.region,
                    annotationItems: [Marker(location: MapMarker(coordinate: viewModel.coordinateForMap))]) { (marker) in
                    marker.location
                }
            }
        }.onAppear {
            viewModel.reconcileLocation(location: locationResult)
        }.onDisappear {
            viewModel.clear()
        }
        .navigationTitle(Text(locationResult.title))
    }
}

struct VSearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        VSearchView()
    }
}


/*import SwiftUI
import MapKit

struct VSearchView: View {

    @FocusState var isFocused: Bool
    
    @State var searchText: String
    @State var opacity = 0.0
    
    /*@State var searchRequest = DSearchRequest(searchRegion: MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.476833, longitude: -0.000536),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)))*/
    

    var body : some View {
        
        VStack(alignment: .center, spacing: 10.0){
            
            searchField
            
            searchResults
        }
    }

    private func clearText() -> Void {
        searchText = ""
    }
    
    private func initiateSearch() -> Void {
        //searchRequest.search(searchQuery: searchText)
    }
    
    private var searchField: some View {
        
        VStack(alignment: .leading, spacing: 10.0){
            
            Text("Search").font(.title3).padding()
            
            ZStack(alignment: .leading){
                STransparentCard(width: 360.0, height: 50.0)
                    .scaleEffect(x: isFocused ? 0.8 : 1.0, y: 1.0, anchor: .leading)
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 200.00, initialVelocity: 20.0), value: isFocused)
                
                // Search field
                HStack(spacing: 10.0){
                    Text("\(Image(systemName: "magnifyingglass"))").padding(.leading)
                    TextField("Search", text: $searchText).frame(width: 240.0, height: 60.0).focused($isFocused).onChange(of: searchText, perform: {_ in initiateSearch()})
                    if isFocused {
                        Button("Cancel"){
                            isFocused = false
                            clearText()
                        }.foregroundColor(Color(red: 0.25, green: 0.6, blue: 1.0, opacity: self.opacity))
                            .onAppear{
                                withAnimation(.easeIn(duration: 0.5)){
                                    opacity = 1.0
                                }
                            }.onDisappear{
                                withAnimation(.easeOut(duration: 0.5)){
                                    opacity = 0.0
                                }
                            }
                    }
                }
            }
        }
    }
    
    private var searchResults: some View {
        
        ZStack{
            STransparentCard(width: 360.0, height: 180.0)

        }
    }
}

struct VSearchView_Previews: PreviewProvider {
    
    static var previews: some View {
        VSearchView(searchText: "")
    }
}*/

