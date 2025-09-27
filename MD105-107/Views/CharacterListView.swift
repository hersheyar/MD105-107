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
        characters.filter { character in
            filters.matchesPersistent(character)
        }
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
                List {
                    ForEach(filteredCharacters, id: \.persistentModelID) { character in
                        let marvelCharacter = convertToMarvelCharacter(character)
                        
                        NavigationLink {
                            CharacterDetailView(character: .constant(marvelCharacter))
                        } label: {
                            CharacterCard(character: .constant(marvelCharacter))
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
        .onAppear {
            addSampleDataIfNeeded()
        }
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
    
    private func addSampleDataIfNeeded() {
        if characters.isEmpty {
            for sampleCharacter in MarvelCharacter.sample {
                let persistentCharacter = PersistentCharacter(
                    name: sampleCharacter.name,
                    alias: sampleCharacter.alias,
                    characterDescription: sampleCharacter.description,
                    imageName: sampleCharacter.imageName,
                    rating: sampleCharacter.rating,
                    review: sampleCharacter.review,
                    isFavorite: sampleCharacter.isFavorite
                )
                modelContext.insert(persistentCharacter)
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
