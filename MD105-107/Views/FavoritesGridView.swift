//
//  FavoritesGridView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI

struct FavoritesGridView: View {
    @Binding var characters: [MarvelCharacter]
    @State private var isShowingFiltersView: Bool = false
    @State private var filters = CharacterFilters()
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.black, .red.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(edges: [.leading, .trailing])
                
                let favorites = $characters.filter { $0.wrappedValue.isFavorite }
                
                if favorites.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text("No Favorites Yet").font(.headline)
                        Text("Tap the heart in Characters to add them here.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favorites) { $character in
                                NavigationLink {
                                    CharacterDetailView(character: $character)
                                } label: {
                                    SquareCardView(character: $character)
                                        .transition(.asymmetric(
                                            insertion: .scale.combined(with: .opacity),
                                            removal: .scale.combined(with: .opacity)
                                        ))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                        .animation(.easeInOut, value: favorites.count)
                    }
                }
            }
            .navigationTitle("Favorite Characters")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isShowingFiltersView = true }) {
                    ZStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                            .accessibilityLabel("Filter favorites")
                        
                        if filters.hasActiveFilters {
                            Circle()
                                .fill(.red)
                                .frame(width: 8, height: 8)
                                .offset(x: 8, y: -8)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingFiltersView) {
            FilterView(filters: $filters)
        }
    }
}

#Preview {
    FavoritesGridView(characters: .constant(MarvelCharacter.sample))
}
