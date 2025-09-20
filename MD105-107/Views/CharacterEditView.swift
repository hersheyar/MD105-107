//
//  CharacterEditView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/20/25.
//

import SwiftUI

struct CharacterEditView: View {
    @Binding var character: MarvelCharacter
    @Environment(\.dismiss) private var dismiss
    @State private var draft: MarvelCharacter
    
    init(character: Binding<MarvelCharacter>) {
        self._character = character
        self._draft = State(initialValue: character.wrappedValue)
    }
    
    var body: some View {
        Form {
            Section("Identity") {
                TextField("Alias", text: $draft.alias)
                TextField("Name", text: $draft.name)
                TextField("Description", text: $draft.description, axis: .vertical)
            }
            
            Section("My Review") {
                Stepper("Rating: \(draft.rating)", value: $draft.rating, in: 1...5)
                TextField("Review", text: $draft.review, axis: .vertical)
                Toggle("Favorite", isOn: $draft.isFavorite)
            }
        }
        .navigationTitle("Edit Character")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    character = draft
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CharacterEditView(character: .constant(MarvelCharacter.sample[0]))
    }
}
