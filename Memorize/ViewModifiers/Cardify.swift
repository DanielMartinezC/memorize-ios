//
//  Cardify.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 6/6/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth) // Stroke a line around the edges of RoundedRectangle Shape and replace it with this new View
                content
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill() // If no color assgined, enviroment color will be applied. In this case is orange from HStack
            }
        }
    }
}

extension View {
    
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
    
}
