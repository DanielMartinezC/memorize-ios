//
//  ContentView.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/21/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import SwiftUI

/* ------------------------ MVVM ------------------------ */
/*
                   -----------
           -----> | ViewModel | <------
          /     _  -----------         \
  notify /     /              |___       \ calls intent function (<-)
change  /     /                   \       \
  (->) /     / modifies            \       \
      /     /  the model    publish \       \
  -------  <     (<-)         (->)   -> ------
 | Model |                             | View |
  -------                               ------
 
 Model:
    - UI independent part (dont import SwiftUI)
    - Encapsulate Data + Logic (data and what happens when I modify something)
    - Is "the truth": Always go for the model to get the real info
 
 View:
    - Refects the Model always
    - Stateles: Dont have its own state. Takes what there is and the model and show it. Only do it when model changes.
    - Declared: We declare what the user interface will look like, different than the old way (mvc) which is Imperative (we tell for eg arrange this things, do this do that with functions, if we consider time dimension we need to consider when to call this methods). Declared is timeless in that way. Views are struct, which by default are read only, so in that we case we cant modify them with own methods.
    - Reactive: When the model change, the View automatically changes.
 
 ViewModel:
    - Binds View to Model: Notify when a change happen to de Model the View changes.
    - Interpreter: It acts as an interpreter from Model to View. Eg from response model to own view model.
    - If Model is a struct is easy to let know ViewModel it has change. ViewModel needs to check this (if Model has change)
    - Publishes that "something changed". The View subscribe for this publish, and when its get notified that something have changed asks the ViewModel: "what have changed?" and pull the data
    - Process user intent: Eg: Choose a card. ViewModel makes functions availble to the View to call (on tap gestures), this are call intent functions. After that modify the model (could change property, modify array
*/
/* ------------------------ MVVM ------------------------ */


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
                CardView(isFaceUp: false)
            }
        }
            .foregroundColor(Color.orange) // All orange on view inside this ZStack
            .padding() // Padding this ZStack
            .font(Font.largeTitle) // All texts inside ZStack font
    }
}

struct CardView: View {
    var isFaceUp: Bool // If we give default value it wont be required on initializer
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0) // Stroke a line around the edges of RoundedRectangle Shape and replace it with this new View
                Text("👻")
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill() // If no color assgined, enviroment color will be applied. In this case is orange from HStack
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
