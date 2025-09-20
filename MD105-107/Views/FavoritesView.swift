//
//  FavoritesView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var characters: [MarvelCharacter]

    private var favoriteIndices: [Int] {
        characters.indices.filter { characters[$0].isFavorite }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .red.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: [.leading, .trailing]) // keep nav + tab bar system default

            if favoriteIndices.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "heart.slash")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("No Favorites Yet").font(.headline)
                    Text("Tap the heart in Characters to add them here.")
                        .font(.subheadline).foregroundColor(.secondary)
                }
                .padding()
            } else {
                List {
                    ForEach(favoriteIndices, id: \.self) { i in
                        NavigationLink {
                            CharacterDetailView(character: $characters[i])
                        } label: {
                            CharacterCard(character: $characters[i])
                                .transition(.move(edge: .trailing).combined(with: .opacity))
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
                                        .shadow(radius: 4, y: 2)
                                )
                        }
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .listStyle(.plain)
                .animation(.easeInOut, value: favoriteIndices.count)
            }
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FavoritesView(characters: .constant(MarvelCharacter.sample))
    }
}
