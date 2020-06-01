//
//  GradientButtonStyle.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/31/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//
import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    
    var color: Color = Color.red
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.75), color.opacity(0.5)]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
    }
}
