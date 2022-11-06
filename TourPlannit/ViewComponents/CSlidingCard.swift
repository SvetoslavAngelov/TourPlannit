//
//  CSlidingCard.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

/*
    This component describes a sliding card which snaps to position
 */

import SwiftUI

enum CardPosition : Double {
    
    // The screen size depends on the iPhone model.
    // The card position is expressed as % of
    // the screen height. For example, with a screen size
    // of 1000 pt, the middle position is y = 1000 * 0.4,
    // while the top position is y = 0.0, or y = 1000 * 0.0.
    
    case top = 0.0
    case middle = 0.4
    case bottom = 0.8
}

enum DragDirection {
    case largeUp
    case largeDown
    case smallUp
    case smallDown
}

struct CSlidingCard<Content: View> : View {
    
    // Content of other views
    private var content: () -> Content
    
    // Optional action executed at the end of each drag action
    private var action: Optional<() -> Void>
    
    // Card dimensions
    private var width: CGFloat
    private var height: CGFloat
    private var alignment: Alignment
    
    // The position at which the card is snapped in
    @State private var cardPosition: CardPosition
    
    // Determines whether the spring animation should play.
    @State private var isAnimationTriggered: Bool = false
    
    // The size of the drag gesture.
    @GestureState private var dragSize = CGSize(width: 0.0, height: 0.0)
    
    /*
        Class member function interface
     */
    
    // Default initialiser, without an additional action specified
    init(width: CGFloat, height: CGFloat, alignment: Alignment, cardPosition: CardPosition, @ViewBuilder content: @escaping () -> Content) {

        self.width = width
        self.height = height
        self.alignment = alignment
        self.cardPosition = cardPosition
        
        self.action = nil
        
        self.content = content
    }
    
    // Initialiser with an additional action attached to each drag gesture
    init(width: CGFloat, height: CGFloat, alignment: Alignment, cardPosition: CardPosition, action: @escaping () -> Void,@ViewBuilder content: @escaping () -> Content) {

        self.width = width
        self.height = height
        self.alignment = alignment
        self.cardPosition = cardPosition
        
        self.action = action
        
        self.content = content
    }
    
    private func setCardPosition(dragGestureValue: DragGesture.Value) -> Void {
        
        switch getDragDirection(dragGestureValue) {
            
        case .largeUp:
            cardPosition = .top
        case .largeDown:
            cardPosition = .bottom
        case .smallUp:
            switch cardPosition {
        
            case .top:
                break
            case .middle:
                cardPosition = .top
            case .bottom:
                cardPosition = .middle
            }
        case .smallDown:
            switch cardPosition {
                
            case .top:
                cardPosition = .middle
            case .middle:
                cardPosition = .bottom
            case .bottom:
                break
            }
        }
        
        // Reset animation status
        isAnimationTriggered = false
        
        // Perform optional action at the end of this gesture
        if let action {
            action()
        }
    }
    
    private func getDragDirection(_ dragGestureValue: DragGesture.Value) -> DragDirection {
        
        let translationSize = CGSize(width: 0.0, height: self.height)
        
        if dragGestureValue.translation.height > 0 && abs(dragGestureValue.predictedEndTranslation) > translationSize{
            
            return .largeDown
        } else if dragGestureValue.translation.height < 0 && abs(dragGestureValue.predictedEndTranslation) > translationSize {
            
            return .largeUp
        } else if dragGestureValue.translation.height < 0 && abs(dragGestureValue.predictedEndTranslation) <= translationSize {
            
            return .smallUp
        } else {
            
            return .smallDown
        }
    }
    
    /*
        View body interface
     */
    
    var body: some View {
        
        let dragAction = DragGesture()
            .updating($dragSize) {
                dragAction, state, transaction in state = dragAction.translation
            }
            .onChanged{_ in
                isAnimationTriggered = true
            }
            .onEnded(setCardPosition)
        
        return ZStack(alignment: alignment) {
            
            // Card material
            SRegularCard(width: self.width, height: self.height)
            
            // Handle
            RoundedRectangle(cornerRadius: 20.0)
                .size(width: 38.0, height: 6.0)
                .offset(x: (self.width * 0.5) - 19.0, y: 10.0)

                // Content views
                content()
        }
        // TODO replace the y check with card's latest position
        .offset(x: 0.0, y: cardPosition == .top && dragSize.height < 0 ? 0.0 : dragSize.height)
        .gesture(dragAction)
        .onTapGesture {
            cardPosition = .top
            isAnimationTriggered = true
        }
        .offset(x: 0.0, y: self.height * cardPosition.rawValue)
        .animation(.interpolatingSpring(stiffness: 400.0, damping: 400.0, initialVelocity: 20.0), value: isAnimationTriggered)
    }
}

struct CSlidingCard_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ screen in
            CSlidingCard(width: screen.size.width, height: screen.size.height, alignment: .top, cardPosition: .top){
                
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}
