//
//  CTransparentCard.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

/*
    Basic card shape component using Swift's thin material
    for a more blurry/glassy look.
 */

import SwiftUI

struct STransparentCard: View {
    private var width: CGFloat
    private var height: CGFloat
    private var color: Color
    
    init(width: CGFloat, height: CGFloat, color: Color){
        
        self.width = width
        self.height = height
        self.color = color
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0.0)
            .frame(width: width, height: height)
            .background(color)
            .blendMode(.overlay)
            .background(.ultraThinMaterial)
            .cornerRadius(20.0)
    }
}

struct STransparentCard_Previews: PreviewProvider {
    static var previews: some View {
        STransparentCard(width: 360, height: 180, color: .orange)
    }
}
