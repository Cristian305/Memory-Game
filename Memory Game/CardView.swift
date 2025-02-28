//
//  CardView.swift
//  Memory Game
//
//  Created by Cristian Gonzalez on 2/25/25.
//

import SwiftUI

// Card View
struct CardView: View {
    let card: Card
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 2)
                    Text(card.content)
                        .font(.largeTitle)
                } else if card.isMatched {
                    // Card is matched, make it invisible
                    Color.clear
                } else {
                    // Card is face down
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .rotation3DEffect(
                .degrees(card.isFaceUp ? 0 : 180),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .animation(.default, value: card.isFaceUp)
            .animation(.default, value: card.isMatched)
        }
        .disabled(card.isMatched)
    }
}
