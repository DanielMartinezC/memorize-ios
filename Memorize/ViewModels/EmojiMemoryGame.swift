//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/22/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import SwiftUI

// ViewModels are always class
class EmojiMemoyGame {
    
    // Close Model access to the View with private.
    //If we only want EmojiMemoryGame to modify but all can see this property we could also do: private(set) var gameModel: MemoryGame<String>
    private var gameModel: MemoryGame<String> = EmojiMemoyGame.createMemoryGame()
    
    // Static because is a not an instance, we send this as a type
    static func createMemoryGame() -> MemoryGame<String> {
        
let emojis: Array<String> = ["👻", "🎃", "🕷", "🧟‍♂️", "🍬","🧙‍♂️", "🍫", "🥧", "🥦", "🐲", "🕸", "🧚"].shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) { pairIndex in //The game start up with a random number of pairs of cards between 2 pairs and 5 pairs.
            emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    // Hide game model but enable the view to consume cards via `cards`
    var cards: Array<MemoryGame<String>.Card> {
        gameModel.cards
    }
    
    var amountOfPairs: Int {
        gameModel.cards.count/2
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        gameModel.choose(card: card)
    }
}
