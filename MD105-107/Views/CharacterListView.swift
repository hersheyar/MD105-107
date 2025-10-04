//
//  CharacterListView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI
import SwiftData

struct CharacterListView: View {
    @Query private var characters: [PersistentCharacter]
    @Environment(\.modelContext) private var modelContext
    @State private var filters = CharacterFilters()
    @State private var isShowingFilters = false
    @State private var isShowingSettings = false
    @State private var listSettings = CharacterListSettings()
    
    private var filteredCharacters: [PersistentCharacter] {
        characters.filter { filters.matchesPersistent($0) }
    }
    
    private var backgroundGradient: LinearGradient {
        listSettings.backgroundColor.gradient
    }

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea(edges: [.leading, .trailing])

            if filteredCharacters.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: filters.hasActiveFilters ? "magnifyingglass" : "person.3.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.secondary)
                    
                    Text(filters.hasActiveFilters ? "No Characters Found" : "No Characters")
                        .font(.headline)
                    
                    Text(filters.hasActiveFilters ?
                         "Try adjusting your filters to see more characters." :
                         "Add some characters to get started.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    if filters.hasActiveFilters {
                        Button("Clear Filters") {
                            withAnimation { filters.clearAll() }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                    }
                }
                .padding()
            } else {
                List {
                    ForEach(filteredCharacters) { character in
                        NavigationLink {
                            CharacterDetailView(character: .constant(
                                MarvelCharacter(
                                    name: character.name,
                                    alias: character.alias,
                                    description: character.characterDescription,
                                    imageName: character.imageName,
                                    rating: character.rating,
                                    review: character.review,
                                    isFavorite: character.isFavorite
                                )
                            ))
                        } label: {
                            CharacterCard(character: character)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
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
            }
        }
        .onAppear { addSampleDataIfNeeded() }
        .navigationTitle("Marvel Characters")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { isShowingSettings = true }) {
                    Image(systemName: "gear")
                        .font(.title2)
                        .accessibilityLabel("Settings")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { isShowingFilters = true }) {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .font(.title2)
                        .accessibilityLabel("Filter characters")
                }
            }
        }
        .sheet(isPresented: $isShowingFilters) {
            FilterView(filters: $filters)
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(listSettings: $listSettings)
        }
    }
    
    private func addSampleDataIfNeeded() {
        if characters.isEmpty {
            for sample in MarvelCharacter.sample {
                let new = PersistentCharacter(
                    name: sample.name,
                    alias: sample.alias,
                    characterDescription: sample.description,
                    imageName: sample.imageName,
                    rating: sample.rating,
                    review: sample.review,
                    isFavorite: sample.isFavorite
                )
                modelContext.insert(new)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CharacterListView()
    }
    .modelContainer(for: [PersistentCharacter.self])
}
