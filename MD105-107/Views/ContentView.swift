//
//  ContentView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/11/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            NavigationStack {
                CharacterListView()
            }
            .tabItem {
                Label("Characters", systemImage: "person.3.fill")
            }
            
            NavigationStack {
                FavoritesGridView()
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
        .modelContainer(for: [PersistentCharacter.self])
}
