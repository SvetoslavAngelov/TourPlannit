//
//  RTouristAttractionRow.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

/*
    Describes a tourist attraciton row and the key attributes
    shown in it.
 */

import SwiftUI

struct RTouristAttractionRow: View {
    var touristAttraction: DTouristAttraction
    
    var body: some View {
        ZStack{
            STransparentCard(width: 360.0, height: 120.0, color: Color(red: 0.43, green: 0.43, blue: 0.43, opacity: 1.0))
                .cornerRadius(20.0)
                .shadow(color: .gray, radius: 1.0)
            
            contents
        }
    }
    
    var contents: some View {
        VStack(alignment: .leading, spacing: 10.0){
            Text(touristAttraction.name).font(.subheadline).bold()
            HStack (alignment: .center, spacing: 20.0){
                touristAttraction.attractionImage
                    .resizable()
                    .frame(width: 80.0, height: 60.0)
                    .cornerRadius(10.0)
                VStack{
                    Text("Hours").font(.subheadline)
                    touristAttraction.isOpen ? Text("  Open ").font(.subheadline).foregroundColor(.green).bold() :
                    Text("Closed").font(.subheadline).foregroundColor(.red).bold()
                }
                VStack{
                    Text("Rating").font(.subheadline)
                    Text("\(touristAttraction.rating, specifier: "%.2f")").font(.subheadline).foregroundColor(.yellow).bold()
                }
                VStack{
                    Text("Distance").font(.subheadline)
                    Text("\(touristAttraction.distance, specifier: "%.2f")").font(.subheadline).bold()
                }
                VStack{
                    Text("Visit").font(.subheadline)
                    touristAttraction.isFavourite ?
                    Text(Image(systemName: "star.fill")).font(.subheadline).foregroundColor(.yellow) :
                            Text(Image(systemName: "star")).font(.subheadline)
                }
            }
        }
    }
}

struct RTouristAttractionRow_Previews: PreviewProvider {
    static var previews: some View {
        RTouristAttractionRow(touristAttraction: touristAttractions[0])
    }
}
