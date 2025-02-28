//
//  ResetButton.swift
//  Memory Game
//
//  Created by Cristian Gonzalez on 2/25/25.
//

import SwiftUI

// Reset Button
struct ResetButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.counterclockwise")
                .font(.system(size: 18, weight: .bold))
                .padding(8)
                .background(Color.gray.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}
