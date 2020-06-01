//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/21/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemoryGameVM: EmojiMemoyGame // our ViewModel. @ObservedObject is a wwapper to subscribe to changes on our VM Published objects
    
    // Computed property but without the need of `return`
    // `some` keyword indicates that body property can be any type as longs as it fullfils View. It is View instead of Text because we know that this computed property may get bigger, in this case compiler will detect the property value kind
    var body: some View {
        // HStack, ForEach, ZStack, etc are all combiners
        // Horizontal Stack. Accept spacing param for space between
        VStack {
            Text("\(emojiMemoryGameVM.themeName)")
                .font(.largeTitle)
            Text("Score: \(emojiMemoryGameVM.score)")
                .font(.title)
            GridView(items: emojiMemoryGameVM.cards) { card in
                CardView(card: card).onTapGesture {
                    self.emojiMemoryGameVM.choose(card: card)
                }
            }
            Button("New Game", action: {
                self.emojiMemoryGameVM.newGame()
                })
                .buttonStyle(GradientButtonStyle(color: emojiMemoryGameVM.themeColor))
        }
            .padding(5)
            .foregroundColor(emojiMemoryGameVM.themeColor) // All orange on view inside this ZStack
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card // If we give default value it wont be required on initializer
    
    // If local properties are needed to draw our body is better to create them on struct as computed: Eg: var test: Int { return 0 }.
    // We could do it inside body but this is a better way.
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth) // Stroke a line around the edges of RoundedRectangle Shape and replace it with this new View
                Text(card.content)
            } else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill() // If no color assgined, enviroment color will be applied. In this case is orange from HStack
                }
            }
        }
            .padding(5)
            .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    private let fontScaleFactor: CGFloat = 0.75
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(emojiMemoryGameVM: EmojiMemoyGame())
    }
}
#endif


/*
/* ------------------------------------------------ MVVM ------------------------------------------------ */

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

/* ------------------------------------------------ MVVM ------------------------------------------------ */
*/

/*
 Comments:
 
 Usually go for standing arguments. Eg padding, stack spacing, radius type, etc
 On functions or views: If no comments can ommit () and just go for second param `content` with {}
*/
