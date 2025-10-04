//
//  SquareCardView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI

struct SquareCardView: View {
    @Bindable var character: PersistentCharacter
    
    @State private var showGhost = false
    @State private var ghostScale: CGFloat = 1.0
    @State private var ghostOffset: CGFloat = 0.0
    @State private var ghostOpacity: Double = 0.0
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 8) {
                Image(character.imageName)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 4)
                
                Text(character.alias)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                
                HStack(spacing: 2) {
                    ForEach(0..<character.rating, id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                    }
                }
            }
            .frame(width: 150)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.ultraThinMaterial)
                    .shadow(radius: 4)
            )
            
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
                    
                    if character.isFavorite {
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
                    }
                } label: {
                    Image(systemName: character.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(character.isFavorite ? .red : .white.opacity(0.8))
                        .shadow(
                            color: character.isFavorite ? .red.opacity(0.6) : .black.opacity(0.6),
                            radius: character.isFavorite ? 4 : 2
                        )
                        .font(.title2)
                        .scaleEffect(character.isFavorite ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: character.isFavorite)
                }
                .buttonStyle(.plain)
                .padding(8)
            }
        }
    }
}

#Preview("Square Card", traits: .sizeThatFitsLayout) {
    SquareCardView(character: PersistentCharacter(
        name: "Peter Parker",
        alias: "Spider-Man",
        characterDescription: "Friendly neighborhood hero with spider-powers.",
        imageName: "spiderman",
        rating: 5,
        review: "Heart + humor.",
        isFavorite: true
    ))
    .padding()
}
