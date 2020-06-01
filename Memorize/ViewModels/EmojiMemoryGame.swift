//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/22/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import SwiftUI
import Combine

// ViewModels are always class. ObservableObject Implements objectWillChange property, which will notify subscribers and objet has changed with Publish
class EmojiMemoyGame: ObservableObject {
    
    // Close Model access to the View with private.
    // If we only want EmojiMemoryGame to modify but all can see this property we could also do: private(set) var gameModel: MemoryGame<String>
    // @Published is a wrapper that every time out model changes it calls objetWillChange
    @Published private var gameModel: MemoryGame<String> = EmojiMemoyGame.createMemoryGame()
    
    private(set) var score: Int = 0
    
    // Static because is a not an instance, we send this as a type
    static func createMemoryGame() -> MemoryGame<String> {
        let theme = EmojiMemoyGame.addTheme()
        let emojis: Array<String> = theme.emojis.shuffled()
        return MemoryGame<String>(theme: theme, numberOfPairsOfCards: theme.pairsToShow) { pairIndex in //The game start up with a random number of pairs of cards between 2 pairs and 5 pairs.
            emojis[pairIndex]
        }
    }
    
    static func addTheme() -> GameTheme {
        Themes.allCases.map({ $0.game }).shuffled()[0]
    }
    
    // MARK: - Access to the Model
    
    // Hide game model but enable the view to consume cards via `cards`
    var cards: Array<MemoryGame<String>.Card> {
        gameModel.cards
    }
    
    var amountOfPairs: Int {
        gameModel.cards.count/2
    }
    
    var themeColor: Color {
        gameModel.theme.color
    }
    
    var themeName: String {
        gameModel.theme.name
    }
    
    // MARK: - Intent(s)
    
    func newGame() {
        gameModel = EmojiMemoyGame.createMemoryGame()
        score = 0
    }
    
    private var temporalScore: Int = 0
    
    func choose(card: MemoryGame<String>.Card) {
        gameModel.choose(card: card)
        
        temporalScore += card.seen ? -1 : 0
        
        // If Player have already face upo two cards
        if !gameModel.currentyPlaying {
            // Get updated card version
            if let selectedCard = cards.first(where: { $0.id == card.id }) {
                 // If match +2 else -1 for each of the cards that have already been seen
                score += selectedCard.isMatched ? 2 : temporalScore
                temporalScore = 0
            }
        }
    }
    
}
