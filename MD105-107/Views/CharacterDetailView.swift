//
//  CharacterDetailView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI

struct CharacterDetailView: View {
    @Binding var character: MarvelCharacter
    @State private var imageScale: CGFloat = 0.9
    @State private var showingEdit = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(character.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .shadow(radius: 8)
                    .scaleEffect(imageScale)
                    .onAppear {
                        withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                            imageScale = 1.0
                        }
                    }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(character.alias)
                        .font(.largeTitle).bold()
                    Text(character.name)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                
                Text(character.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("My Review").font(.title2).bold()
                        Spacer()
                        HStack {
                            Text("\(character.rating)")
                            Image(systemName: "star.fill").foregroundColor(.yellow)
                        }
                    }
                    Text(character.review.isEmpty ? "No review yet." : character.review)
                }
            }
            .padding()
        }
        .navigationTitle(character.alias)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") { showingEdit = true }
            }
        }
        .sheet(isPresented: $showingEdit) {
            NavigationStack {
                CharacterEditView(character: $character)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(character: .constant(MarvelCharacter.sample[1]))
    }
}
