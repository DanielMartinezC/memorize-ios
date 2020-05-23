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
    
    func choose(card: Card) {
        print("card choosen: \(card)")
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent // CardContent is a 'don`t care' type. It has to be defined with <CardContent> (<Element>) in the main struct (MemoryGame)

        
    }
}
