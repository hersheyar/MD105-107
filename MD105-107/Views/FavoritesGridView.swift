//
//  FavoritesGridView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI
import SwiftData

struct FavoritesGridView: View {
    @Query private var allCharacters: [PersistentCharacter]
    @State private var isShowingFiltersView: Bool = false
    @State private var filters = CharacterFilters()
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    private var favoriteCharacters: [PersistentCharacter] {
        allCharacters.filter { $0.isFavorite }
    }
    
    private var filteredFavorites: [PersistentCharacter] {
        favoriteCharacters.filter { character in
            filters.matchesPersistent(character)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [.black, .red.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(edges: [.leading, .trailing])
                
                if filteredFavorites.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: favoriteCharacters.isEmpty ? "heart.slash" : "magnifyingglass")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text(favoriteCharacters.isEmpty ? "No Favorites Yet" : "No Favorites Found")
                            .font(.headline)
                        Text(favoriteCharacters.isEmpty ?
                             "Tap the heart in Characters to add them here." :
                             "Try adjusting your filters to see more favorites.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        
                        if filters.hasActiveFilters && !favoriteCharacters.isEmpty {
                            Button("Clear Filters") {
                                withAnimation {
                                    filters.clearAll()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                        }
                    }
                    .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredFavorites, id: \.persistentModelID) { character in
                                let marvelCharacter = convertToMarvelCharacter(character)
                                
                                NavigationLink {
                                    CharacterDetailView(character: .constant(marvelCharacter))
                                } label: {
                                    SquareCardView(character: .constant(marvelCharacter))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Favorite Characters")
            .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isShowingFiltersView = true }) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title2)
                        .accessibilityLabel("Filter favorites")
                }
            }
        }
        .sheet(isPresented: $isShowingFiltersView) {
            FilterView(filters: $filters)
        }
    }
    
    private func convertToMarvelCharacter(_ persistent: PersistentCharacter) -> MarvelCharacter {
        MarvelCharacter(
            name: persistent.name,
            alias: persistent.alias,
            description: persistent.characterDescription,
            imageName: persistent.imageName,
            rating: persistent.rating,
            review: persistent.review,
            isFavorite: persistent.isFavorite
        )
    }
}

#Preview {
    FavoritesGridView()
        .modelContainer(for: [PersistentCharacter.self])
}
