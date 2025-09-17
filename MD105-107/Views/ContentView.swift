//
//  ContentView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var books = [
        Book(
            title: "The Fellowship of the Ring",
            author: "J.R.R. Tolkien",
            image: "tfotr",
            description: "The first book in the trilogy",
            rating: 4,
            review: "A classic tale of good vs evil, a little slow at first but very rewarding."
        ),
        Book(
            title: "To Kill a Mockingbird",
            author: "Harper Lee",
            image: "tkam",
            description: "Harper Lee's classic novel exploring racial injustice and moral growth in the Deep South.",
            rating: 5,
            review: "An incredible masterpiece that everyone should read."
        ),
        Book(
            title: "12 Rules for Life",
            author: "Jordan Peterson",
            image: "12rfl",
            description: "Jordan Peterson's guide to living a meaningful and responsible life through practical rules.",
            rating: 3,
            review: "Interesting perspectives but can be repetitive at times."
        ),
        Book(
            title: "The Great Gatsby",
            author: "F. Scott Fitzgerald",
            image: "Tgg",
            description: "F. Scott Fitzgerald's story of Jay Gatsby and the pursuit of the American Dream.",
            rating: 4,
            review: "Beautiful writing and compelling characters. A true American classic."
        )
    ]
    
    var body: some View {
        NavigationStack {
            List(books) { book in
                NavigationLink(destination: BookDetailView(book: binding(for: book))) {
                    HStack(alignment: .top, spacing: 12) {
                        Image(book.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 70)
                            .cornerRadius(5)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(book.title)
                                .font(.headline)
                            
                            Text(book.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("My Books")
        }
    }
    
    private func binding(for book: Book) -> Binding<Book> {
        guard let bookIndex = books.firstIndex(where: { $0.id == book.id }) else {
            fatalError("Can't find book in array")
        }
        return $books[bookIndex]
    }
}

#Preview {
    ContentView()
}
