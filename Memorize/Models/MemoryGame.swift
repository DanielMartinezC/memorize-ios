//
//  MemoryGame.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/22/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    mutating func choose(card: Card) {
        print("card choosen: \(card)")
        guard let chosenIndex: Int = self.index(of: card) else { return }
        self.cards[chosenIndex].isFaceUp.toggle()
        
    }
    
    func index(of card: Card) -> Int? {
        self.cards.firstIndex(where: { $0.id == card.id }) ?? nil
    }
    
    // We want to create this game with a number of cards, not assigning cards per se. We also pass a function as parameter, this will be regular on this architecture (due to comunication with VM)
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
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
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent // CardContent is a Generic or 'don`t care' type. It has to be defined with <CardContent> (<Element>) in the main struct (MemoryGame)
    }
}
