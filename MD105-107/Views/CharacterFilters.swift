//
//  CharacterFilters.swift
//  MD105-107
//
//  Created by Andrew Hershey on 9/27/25.
//

import Foundation

struct CharacterFilters: Equatable {
    var showFavoritesOnly: Bool = false
    var minimumRating: Int = 1
    var searchText: String = ""
    
    var hasActiveFilters: Bool {
        showFavoritesOnly || minimumRating > 1 || !searchText.isEmpty
    }
    
    mutating func clearAll() {
        showFavoritesOnly = false
        minimumRating = 1
        searchText = ""
    }
    
    func matches(_ character: MarvelCharacter) -> Bool {
        if showFavoritesOnly && !character.isFavorite {
            return false
        }
        
        if character.rating < minimumRating {
            return false
        }
        
        if !searchText.isEmpty {
            let searchLower = searchText.lowercased()
            return character.alias.lowercased().contains(searchLower) ||
                   character.name.lowercased().contains(searchLower) ||
                   character.description.lowercased().contains(searchLower)
        }
        
        return true
    }
}
