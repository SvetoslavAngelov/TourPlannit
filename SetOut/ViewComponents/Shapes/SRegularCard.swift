//
//  SRegularCard.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 28/09/2022.
//

import SwiftUI

struct SRegularCard: View {
    private var width: CGFloat
    private var height: CGFloat
    
    init(width: CGFloat, height: CGFloat){
        
        self.width = width
        self.height = height
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .strokeBorder(.black, lineWidth: 1.0)
            .frame(width: width, height: height)
            .blendMode(.overlay)
            .background(.regularMaterial)
            .cornerRadius(10.0)
    }
}

struct SRegularCard_Previews: PreviewProvider {
    static var previews: some View {
        SRegularCard(width: 360, height: 180)
    }
}
