//
//  CSearchBar.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 16/10/2022.
//

import SwiftUI

/*
    This is a custom search component which is similar to the built in SwiftUI,
    the main difference is the ability to set the background of the search component
    and the greater flexibility when it comes to animating the various components. 
 */
struct CSearchBar: View {

    var isFocused: FocusState<Bool>.Binding
    @Binding var searchText: String
    @State var cancelButtonOpacity = 0.0
    
    var body : some View {
        
        VStack(alignment: .leading, spacing: 10.0){
            
            Text("Search").font(.title3).padding()
            
            ZStack(alignment: .leading){
                STransparentCard(width: 360.0, height: 50.0)
                    .scaleEffect(x: isFocused.wrappedValue == true ? 0.8 : 1.0, y: 1.0, anchor: .leading)
                    .animation(.interpolatingSpring(stiffness: 200.0, damping: 200.00, initialVelocity: 20.0), value: isFocused.wrappedValue)
                
                // Search field
                HStack(spacing: 10.0){
                    Text("\(Image(systemName: "magnifyingglass"))").padding(.leading)
                    TextField("Search", text: $searchText)
                        .frame(width: 240.0, height: 60.0)
                        .focused(isFocused)
                    if isFocused.wrappedValue {
                        Button("Cancel"){
                            isFocused.wrappedValue = false
                            clearText()
                        }.foregroundColor(Color(red: 0.25, green: 0.6, blue: 1.0, opacity: self.cancelButtonOpacity))
                            .onAppear{
                                withAnimation(.easeIn(duration: 0.5)){
                                    cancelButtonOpacity = 1.0
                                }
                            }.onDisappear{
                                withAnimation(.easeOut(duration: 0.5)){
                                    cancelButtonOpacity = 0.0
                                }
                            }
                    }
                }
            }
        }
    }

    private func clearText() -> Void {
        searchText = ""
    }
}
