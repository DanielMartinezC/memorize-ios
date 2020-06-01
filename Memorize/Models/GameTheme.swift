//
//  GameTheme.swift
//  Memorize
//
//  Created by Daniel Martinez Condinanza on 5/31/20.
//  Copyright © 2020 danielmartinezcg. All rights reserved.
//

import SwiftUI

enum Themes: CaseIterable {
    case hallowen
    case sports
    case animals
    
    var game: GameTheme {
        switch self {
        case .hallowen:
            return GameTheme(name: "Hallowen", emojis: ["👻", "🎃", "🕷", "🧟‍♂️", "🍬","🧙‍♂️", "🍫", "🥧", "🥦", "🐲", "🕸", "🧚"], color: .orange)
        case .sports:
            return GameTheme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎","🏐", "🥏", "🏓", "⛳️", "🎾", "🏏", "🥊"], color: .red)
        case .animals:
            return GameTheme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐻", "🦊","🐨", "🐼", "🦁", "🐯", "🐮", "🐵", "🐝"], color: .green)
        }
    }
}

struct GameTheme {
    
    var name: String
    var emojis: Array<String>
    var color: Color
    var randomPairs: Bool = false
    
    var pairsToShow: Int {
        randomPairs ? Int.random(in: 2...5) : emojis.count/2
    }
}
