//
//  VMainView.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 06/12/2022.
//

import SwiftUI

struct VMainView: View {
    
    @StateObject var locationManager = DLocationManager()
    @EnvironmentObject var slidingCardPosition: DCardPosition
    
    var body: some View {
        
        ZStack {
            CMapView().preferredColorScheme(.light)
            
            GeometryReader{ screen in
                CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .top, cardPosition: slidingCardPosition){
                
                    Button {
                        moveToMiddle()
                    } label: {
                        Text("Update")
                    }.padding()
                    
                }
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private func moveToMiddle() -> Void {
        slidingCardPosition.updatePosition(newPosition: .middle)
    }
}

struct VMainView_Previews: PreviewProvider {
    static var previews: some View {
        VMainView().environmentObject(DCardPosition())
    }
}
