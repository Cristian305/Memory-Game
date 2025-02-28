//
//  MemoryGame.swift
//  Memory Game
//
//  Created by Cristian Gonzalez on 2/25/25.
//

import SwiftUI

// Game model to handle the game logic
class MemoryGame: ObservableObject {
    @Published var cards: [Card] = []
    @Published var flippedCardIndices: [Int] = []
    @Published var score = 0
    @Published var gridSize = 6 // Default to 6 pairs
    
    private let emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐸",
                         "🦄", "🐷", "🦓", "🐮", "🐙", "🦕", "🦖", "🐳"]
    
    init() {
        resetGame()
    }
    
    func setGridSize(_ size: Int) {
        gridSize = size
        resetGame()
    }
    
    func resetGame() {
        // Create pairs of cards with matching emojis
        let shuffledEmojis = emojis.shuffled()
        let selectedEmojis = Array(shuffledEmojis.prefix(gridSize)) // Use selected number of emojis
        let emojiPairs = selectedEmojis + selectedEmojis // Create pairs
        
        // Initialize cards with randomly shuffled emojis
        cards = emojiPairs.shuffled().map { Card(content: $0) }
        flippedCardIndices = []
        score = 0
    }
    
    func flipCard(at index: Int) {
        // Don't allow flipping if card is already matched or if two cards are already flipped
        guard !cards[index].isMatched && flippedCardIndices.count < 2 && !flippedCardIndices.contains(index) else {
            return
        }
        
        // Flip the card
        cards[index].isFaceUp = true
        flippedCardIndices.append(index)
        
        // Check for a match if we have two cards flipped
        if flippedCardIndices.count == 2 {
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        let firstIndex = flippedCardIndices[0]
        let secondIndex = flippedCardIndices[1]
        
        if cards[firstIndex].content == cards[secondIndex].content {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return }
                
                // Remove matched cards
                let matchedContent = self.cards[firstIndex].content
                self.cards.removeAll { $0.content == matchedContent }
                
                self.score += 2
                self.flippedCardIndices = []
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else { return }
                self.cards[firstIndex].isFaceUp = false
                self.cards[secondIndex].isFaceUp = false
                self.flippedCardIndices = []
            }
        }
    }
}
