//
//  RTouristAttractionRow.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI

/*
    Describes a tourist attraciton row and the key attributes
    shown in it.
 */
struct RTouristAttractionRow: View {
    var touristAttraction: DTouristAttraction
    
    var body: some View {
        ZStack(alignment: .leading){
            STransparentCard(width: 360.0, height: 100.0)
                .cornerRadius(10.0)
            
            contents.padding(.leading)
        }
    }
    
    var contents: some View {
        VStack(alignment: .leading, spacing: 10.0){
            Text(touristAttraction.name).font(.headline)
            HStack (alignment: .top, spacing: 30.0){
                touristAttraction.attractionImage
                    .resizable()
                    .frame(width: 40.0, height: 40.0)
                    .cornerRadius(100.0)
                VStack(alignment: .leading){
                    Text("Hours").font(.subheadline)
                    touristAttraction.isOpen ? Text("\(Image(systemName: "clock.badge.checkmark"))").font(.headline).foregroundColor(.green).bold() :
                    Text("\(Image(systemName: "clock.fill"))").font(.headline).foregroundColor(.red).bold()
                }
                VStack(alignment: .leading){
                    Text("Rating").font(.subheadline)
                    HStack{
                        Text("\(Image(systemName: "star.fill"))").foregroundColor(.orange)
                        Text("\(touristAttraction.rating, specifier: "%.1f")").font(.subheadline).bold()
                    }
                }
                VStack(alignment: .leading){
                    Text("Distance").font(.subheadline)
                    Text("\(Image(systemName: "compass.drawing"))  \(touristAttraction.distance, specifier: "%.1f km")").font(.subheadline).bold()
                }
            }
            
            RoundedRectangle(cornerRadius: 20.0)
                .frame(width: 325.0, height: 1)
        }
    }
}

struct RTouristAttractionRow_Previews: PreviewProvider {
    static var previews: some View {
        RTouristAttractionRow(touristAttraction: touristAttractions[2])
    }
}
