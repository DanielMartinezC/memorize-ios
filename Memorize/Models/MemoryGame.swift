//
//  MemoryGame.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/22/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    private(set) var theme: GameTheme
    
    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    var currentyPlaying: Bool {
        return indexOfFaceUpCard != nil
    }
    
    mutating func choose(card: Card) {
        print("card choosen: \(card)")
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[potentialMatchIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                } else {
                    cards[potentialMatchIndex].seen = true
                    cards[chosenIndex].seen = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                // First card of the pair been chosen
                indexOfFaceUpCard = chosenIndex
            }
        }
    }
    
    // We want to create this game with a number of cards, not assigning cards per se. We also pass a function as parameter, this will be regular on this architecture (due to comunication with VM)
    init(theme: GameTheme, numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.theme = theme
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: pairIndex*2, content: content))
            cards.append(Card(id: pairIndex*2+1, content: content))
        }
        cards.shuffle()
    }
    
    // Need to be Identifiable so we can iterate over them and perform other actions via identifier
    struct Card: Identifiable {
        var id: Int // variable call 'id' of any type to fullfill Identifiable protocol
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent // CardContent is a Generic or 'don`t care' type. It has to be defined with <CardContent> (<Element>) in the main struct (MemoryGame)
        var seen: Bool = false
    }
}
