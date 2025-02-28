//
//  Card.swift
//  Memory Game
//
//  Created by Cristian Gonzalez on 2/25/25.
//

import SwiftUI

// Card model to represent each card in the game
struct Card: Identifiable, Equatable {
    let id = UUID()
    let content: String
    var isFaceUp = false
    var isMatched = false
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
}
