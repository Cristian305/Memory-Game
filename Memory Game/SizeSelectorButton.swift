//
//  SizeSelectorButton.swift
//  Memory Game
//
//  Created by Cristian Gonzalez on 2/25/25.
//

import SwiftUI

// Size Selector Button
struct SizeSelectorButton: View {
    @ObservedObject var game: MemoryGame
    
    var body: some View {
        Menu {
            Button("3 Pairs") { game.setGridSize(3) }
            Button("6 Pairs") { game.setGridSize(6) }
            Button("10 Pairs") { game.setGridSize(10) }
        } label: {
            HStack {
                Text("Size: \(game.gridSize)")
                Image(systemName: "chevron.down")
            }
            .padding(8)
            .background(Color.green.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}
