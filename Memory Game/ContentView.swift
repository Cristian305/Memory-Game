//
//  ContentView.swift
//  Memory Game
//
//  Created by Cristian Gonzalez on 2/25/25.
//
import SwiftUI
struct ContentView: View {
    @StateObject private var game = MemoryGame()
    
    // Calculate the grid columns based on grid size
    private var gridColumns: [GridItem] {
        let columnCount = min(Int(sqrt(Double(game.gridSize * 2))), 4)
        return Array(repeating: GridItem(.flexible()), count: columnCount)
    }
    
    var body: some View {
        // Use a GeometryReader to get size info
        GeometryReader { geometry in
            // This VStack is to ensure the header stays at the top
            VStack(spacing: 0) {
                // Fixed header containing buttons and title
                VStack {
                    HStack {
                        // Size selector button in top left
                        SizeSelectorButton(game: game)
                        
                        Spacer()
                        
                        Text("Memory Game")
                            .font(.headline)
                            .bold()
                        
                        Spacer()
                        
                        // Reset button in top right
                        ResetButton {
                            withAnimation {
                                game.resetGame()
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Text("Score: \(game.score)")
                        .font(.title)
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                }
                .background(Color.white)
                .zIndex(1) // Ensure the header stays on top
                
                // Scrollable content area
                ScrollView(.vertical, showsIndicators: true) {
                    VStack {
                        LazyVGrid(columns: gridColumns, spacing: 10) {
                            ForEach(Array(game.cards.enumerated()), id: \.element.id) { index, card in
                                CardView(card: card) {
                                    game.flipCard(at: index)
                                }
                            }
                        }
                        .padding()
                        
                        // Make sure there's enough space at the bottom
                        Spacer()
                            .frame(height: 100)
                    }
                }
                
                // New Game button at the bottom
                VStack {
                    Button("New Game") {
                        withAnimation {
                            game.resetGame()
                        }
                    }
                    .font(.title)
                    .padding()
                    .frame(minWidth: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.vertical, 15)
                }
                .background(Color.white)
                .zIndex(1) // Ensure the footer stays visible
            }
        }
        .edgesIgnoringSafeArea(.bottom) // Make sure we use the full screen height
    }
}
