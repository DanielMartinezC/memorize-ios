//
//  Cardify.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 6/6/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import SwiftUI

// AnimatableModifier = ViewModifier + Animatable. If no animatable it wont take our own animation, instead it will use default
struct Cardify: AnimatableModifier {
    var rotation: Double
    
    /// Card face Based on rotation
    var isFaceUp: Bool {
        rotation < 90
    }
    
    /// Rename animatableData as rotation for our code
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth) // Stroke a line around the edges of RoundedRectangle Shape and replace it with this new View
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            
            RoundedRectangle(cornerRadius: cornerRadius).fill() // If no color assgined, enviroment color will be applied. In this case is orange from HStack
                .opacity(isFaceUp ? 0 : 1)
        }
        .transition(AnyTransition.scale) // Card dissapear transition
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    
}
