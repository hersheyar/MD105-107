//
//  CharacterListView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI

struct CharacterListView: View {
    @Binding var characters: [MarvelCharacter]
    @State private var animate = false
    @State private var filters = CharacterFilters()
    @State private var isShowingFilters = false
    @State private var isShowingSettings = false
    @State private var listSettings = CharacterListSettings()
    
    private var filteredCharacters: [MarvelCharacter] {
        characters.filter { character in
            filters.matches(character)
        }
    }
    
    private var filteredIndices: [Int] {
        characters.indices.filter { index in
            filters.matches(characters[index])
        }
    }

    var body: some View {
        ZStack {
            listSettings.backgroundColor.gradient
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
                    ForEach(filteredIndices, id: \.self) { i in
                        NavigationLink {
                            CharacterDetailView(character: $characters[i])
                        } label: {
                            CharacterCard(character: $characters[i], showRating: listSettings.showRatings, textSize: listSettings.textSize)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.ultraThinMaterial)
                                        .shadow(radius: 4, y: 2)
                                )
                                .offset(x: animate ? 0 : -50)
                                .opacity(animate ? 1 : 0)
                                .animation(
                                    .spring(response: 0.6, dampingFraction: 0.7)
                                        .delay(Double(filteredIndices.firstIndex(of: i) ?? 0) * 0.05),
                                    value: animate
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
        .onAppear { animate = true }
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
                    ZStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                            .accessibilityLabel("Filter characters")
                        
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
        .sheet(isPresented: $isShowingFilters) {
            FilterView(filters: $filters)
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(listSettings: $listSettings)
        }
        .onChange(of: filters) { _, _ in
            animate = false
            withAnimation(.easeInOut(duration: 0.2)) {
                animate = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        CharacterListView(characters: .constant(MarvelCharacter.sample))
    }
}
