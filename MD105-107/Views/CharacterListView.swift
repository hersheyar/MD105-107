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

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.black, .red.opacity(0.6)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea(edges: [.leading, .trailing]) // no top or bottom!

            List {
                ForEach(characters.indices, id: \.self) { i in
                    NavigationLink {
                        CharacterDetailView(character: $characters[i])
                    } label: {
                        CharacterCard(character: $characters[i])
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
                                    .delay(Double(i) * 0.05),
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
        .onAppear { animate = true }
        .navigationTitle("Marvel Characters")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CharacterListView(characters: .constant(MarvelCharacter.sample))
    }
}
