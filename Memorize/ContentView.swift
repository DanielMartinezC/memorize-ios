//
//  ContentView.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/21/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import SwiftUI

/*
 Comments:
 
 Usually go for standing arguments. Eg padding, stack spacing, radius type, etc
 On functions or views: If no comments can ommit () and just go for second param `content` with {}
*/

struct ContentView: View {
    // Computed property but without the need of `return`
    // `some` keyword indicates that body property can be any type as longs as it fullfils View. It is View instead of Text because we know that this computed property may get bigger, in this case compiler will detect the property value kind
    var body: some View {
        // HStack, ForEach, ZStack, etc are all combiners
        // Horizontal Stack. Accept spacing param for space between items
        HStack {
            //First param is an array of items. In this case its an arrange of 0 to 3
            // ForEach(0..<4, content: { index in
            // this previous line can be call like this:
            ForEach(0..<4) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0) // Stroke a line around the edges of RoundedRectangle Shape and replace it with this new View
                    Text("👻")
                }
            }
        }
            .foregroundColor(Color.orange) // All orange on view inside this ZStack
            .padding() // Padding this ZStack
            .font(Font.largeTitle) // All texts inside ZStack font
    }
}






























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
