//
//  BookDetailView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/11/25.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var book: Book
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top, spacing: 16) {
                    Image(book.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 180)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(book.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        
                        Text("by \(book.author)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                
                Text(book.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("My Review")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        HStack(spacing: 2) {
                            Text("\(book.rating)")
                                .font(.system(size: 16, weight: .medium))
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 16))
                        }
                    }
                    
                    Text(book.review)
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink("Edit") {
                    BookEditView(book: $book)
                }
                .foregroundColor(.blue)
            }
        }
    }
}

#Preview {
    NavigationView {
        BookDetailView(
            book: .constant(Book(
                title: "The Fellowship of the Ring",
                author: "J.R.R. Tolkien",
                image: "tfotr",
                description: "The first book in the trilogy",
                rating: 4,
                review: "A classic tale of good vs evil, a little slow at first but very rewarding."
            ))
        )
    }
}
