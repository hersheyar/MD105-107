//
//  BookEditView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/14/25.
//


import SwiftUI

struct BookEditView: View {
    @Binding var book: Book
    @Environment(\.dismiss) private var dismiss
    
    // Local editable copy
    @State private var draft: Book
    
    init(book: Binding<Book>) {
        self._book = book
        // Initialize the draft with the current book
        self._draft = State(initialValue: book.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Information")) {
                    TextField("Title", text: $draft.title)
                    TextField("Author", text: $draft.author)
                    TextField("Description", text: $draft.description, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section(header: Text("My Review")) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Rating")
                            .font(.headline)
                        
                        StarRatingView(rating: $draft.rating)
                    }
                    
                    TextField("Write your review...", text: $draft.review, axis: .vertical)
                        .lineLimit(3...8)
                }
            }
            .navigationTitle("Edit Book")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Discard changes and close
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Commit changes back to the binding
                        book = draft
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

struct StarRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(star <= rating ? .yellow : .gray)
                    .font(.system(size: 24))
                    .onTapGesture {
                        rating = star
                    }
            }
        }
    }
}

#Preview {
    BookEditView(
        book: .constant(Book(
            title: "The Fellowship of the Ring",
            author: "J.R.R. Tolkien",
            image: "alchemist",
            description: "The first book in the trilogy",
            rating: 4,
            review: "A classic tale of good vs evil, a little slow at first but very rewarding."
        ))
    )
}
