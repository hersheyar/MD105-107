//
//  ContentView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var characters = MarvelCharacter.sample
    
    var body: some View {
        TabView {
            NavigationStack {
                CharacterListView(characters: $characters)
            }
            .tabItem {
                Label("Characters", systemImage: "person.3.fill")
            }
            
            NavigationStack {
                FavoritesView(characters: $characters)
            }
            .tabItem {
                Label("Favorites", systemImage: "heart.fill")
            }
        }
        .tint(.red)
    }
}

#Preview {
    ContentView()
}
