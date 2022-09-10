//
//  CRouteOptions.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

/*
    A view component which contains the route options users
    have when defining a route.
 */

import SwiftUI

struct CRouteOptions: View {
    var body: some View {
        ZStack(alignment: .center){
            STransparentCard(width: 360.0, height: 160.0, color: Color(red: 0.43, green: 0.43, blue: 0.43, opacity: 1.0))
                .cornerRadius(20.0)
                .shadow(color: .gray, radius: 1.0)
        
            VStack(alignment: .leading, spacing: 16.0){
                RRouteOptionsRow(sliderInput: 5.0, isEditing: false, sliderRange: 10.0, description: "Distance", imageLiteral: "figure.walk.circle.fill", stringSpecifier: "%.2f", unitMeasure: "km")
            
                RRouteOptionsRow(sliderInput: 4.0, isEditing: false, sliderRange: 8.0, description: "Time Available", imageLiteral: "person.crop.circle.badge.clock.fill", stringSpecifier: "%.1f", unitMeasure: "hours")
            }
        }
    }
}

struct CRouteOptions_Previews: PreviewProvider {
    static var previews: some View {
        CRouteOptions()
    }
}
