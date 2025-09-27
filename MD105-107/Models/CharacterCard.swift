//
//  CharacterCard.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI

struct CharacterCard: View {
    @Binding var character: MarvelCharacter
    var showRating: Bool = true
    var textSize: CharacterListSettings.TextSize = .normal
    
    @State private var showGhost = false
    @State private var ghostScale: CGFloat = 1.0
    @State private var ghostOffset: CGFloat = 0.0
    @State private var ghostOpacity: Double = 0.0
    
    var body: some View {
        HStack(spacing: 16) {
            Image(character.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 80)
                .cornerRadius(8)
                .shadow(radius: 3)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(character.alias)
                    .font(textSize.titleFont)
                Text(character.name)
                    .font(textSize.bodyFont)
                    .foregroundColor(.secondary)
                Text(character.description)
                    .font(textSize.detailFont)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                if showRating {
                    HStack {
                        ForEach(1...5, id: \.self) { star in
                            Image(systemName: star <= character.rating ? "star.fill" : "star")
                                .foregroundColor(star <= character.rating ? .yellow : .secondary)
                                .font(.caption)
                        }
                    }
                }
            }
            
            Spacer()
            
            ZStack {
                if showGhost {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.title2)
                        .scaleEffect(ghostScale)
                        .offset(y: ghostOffset)
                        .opacity(ghostOpacity)
                        .shadow(color: .red.opacity(0.6), radius: 6)
                }
                
                Button {
                    character.isFavorite.toggle()
                    
                    showGhost = true
                    ghostScale = 1.0
                    ghostOffset = 0
                    ghostOpacity = 1.0
                    
                    withAnimation(.easeOut(duration: 0.4)) {
                        ghostScale = 1.8
                        ghostOffset = -80
                        ghostOpacity = 0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showGhost = false
                    }
                } label: {
                    Image(systemName: character.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(character.isFavorite ? .red : .white.opacity(0.8))
                        .shadow(
                            color: character.isFavorite ? .red.opacity(0.6) : .black.opacity(0.6),
                            radius: character.isFavorite ? 4 : 2
                        )
                        .font(.title2)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.vertical, 6)
    }
}

#Preview("Card Preview", traits: .sizeThatFitsLayout) {
    CharacterCard(character: .constant(MarvelCharacter.sample[0]))
        .padding()
}
