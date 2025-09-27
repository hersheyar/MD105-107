//
//  FilterView.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/27/25.
//

import SwiftUI

struct FilterView: View {
    @Binding var filters: CharacterFilters
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Search") {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search characters...", text: $filters.searchText)
                    }
                }
                
                Section("Filters") {
                    Toggle(isOn: $filters.showFavoritesOnly) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            Text("Favorites Only")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("Minimum Rating")
                        }
                        
                        HStack {
                            ForEach(1...5, id: \.self) { rating in
                                Button(action: {
                                    filters.minimumRating = rating
                                }) {
                                    Image(systemName: rating <= filters.minimumRating ? "star.fill" : "star")
                                        .foregroundColor(rating <= filters.minimumRating ? .yellow : .secondary)
                                        .font(.title2)
                                }
                                .buttonStyle(.plain)
                            }
                            Spacer()
                        }
                    }
                }
                
                if filters.hasActiveFilters {
                    Section {
                        Button(action: {
                            withAnimation {
                                filters.clearAll()
                            }
                        }) {
                            HStack {
                                Image(systemName: "trash")
                                Text("Clear All Filters")
                            }
                            .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Filter Characters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .accessibilityLabel("Close filters")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    FilterView(filters: .constant(CharacterFilters()))
}
