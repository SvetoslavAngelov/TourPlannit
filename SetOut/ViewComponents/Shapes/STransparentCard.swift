//
//  CTransparentCard.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import SwiftUI

/*
    Basic card shape component using Swift's thin material
    for a more blurry/glassy look.
 */
struct STransparentCard: View {
    private var width: CGFloat
    private var height: CGFloat
    
    init(width: CGFloat, height: CGFloat){
        
        self.width = width
        self.height = height
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0.0)
            .frame(width: width, height: height)
            .background(.ultraThinMaterial)
            .blendMode(.softLight)
            .cornerRadius(10.0)
    }
}

struct STransparentCard_Previews: PreviewProvider {
    static var previews: some View {
        STransparentCard(width: 360, height: 180)
    }
}
